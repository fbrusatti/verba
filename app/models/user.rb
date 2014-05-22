class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :database_authenticatable, :recoverable, :rememberable,
         :trackable, :validatable, :omniauthable

  # == Associations
  has_many :authorizations

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

  private
  def self.create_devise_user(email, username)
    user = User.new
    user.email = email
    user.password = Devise.friendly_token[0, 20]
    user.save!
    user
  end
end
