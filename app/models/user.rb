class User < ActiveRecord::Base

  # == Devise modules (Other availables: :confirmable, :lockable, :timeoutable)
  devise :database_authenticatable, :recoverable, :rememberable,
         :trackable, :validatable, :omniauthable

  # == Associations
  has_many :authorizations
  has_many :messages

  # == Virtual attribute
  # for authenticating by either username or email
  attr_accessor :login

  # == Class Methods
  def self.from_omniauth(auth, current_user)
    authorization = Authorization.where({ provider: auth.provider.to_s, uid: auth.uid.to_s }).first_or_initialize

    authorization.fetch_info(auth)
    if authorization.user.blank?
      user = current_user.blank? ? User.where('email = ?', auth.info.email).first : current_user
      user = create_devise_user(auth.info.email, auth.info.nickname) if user.blank?
      authorization.user = user
    else
      user = authorization.user
    end
    authorization.save!

    user
  end

  # Override Devise method to allow find users by username or email
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end


  private
  def self.create_devise_user(email, username)
    user = User.new
    user.email = email
    user.username = username || email.split('@').first
    user.password = Devise.friendly_token[0, 20]
    user.save!
    user
  end
end
