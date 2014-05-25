class User < ActiveRecord::Base

  # == Devise modules (Other availables: :confirmable, :lockable, :timeoutable)
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :omniauthable

  # == Associations
  has_many :authorizations
  has_many :messages

  # == Virtual attribute (for authenticating by either username or email)
  attr_accessor :login

  # == Validations
  validates :username, uniqueness: true, presence: true
  with_options :if => :password_required? do |v|
    v.validates_presence_of     :password
    v.validates_confirmation_of :password
    v.validates_length_of       :password, :within => Devise.password_length, :allow_blank => true
  end

  # == Callbacks
  before_validation :check_username, if: 'self.new_record?'

  # == Class Methods
  def self.from_omniauth(auth, current_user)
    authorization = Authorization.where({ provider: auth.provider.to_s, uid: auth.uid.to_s }).first_or_initialize

    authorization.fetch_info(auth)

    if authorization.user.blank?
      # if there is a user in params use it
      user = current_user

      # find an already register user with the same email or username
      if current_user.blank?
        user = User.where(["lower(username) = :username OR lower(email) = :email",
                          { username: auth.info.nickname, email: auth.info.email }]).first
      end

      # if there is no user as params neither exists a user with those params create a new one
      if user.blank? # ToDo if username was the found record, check that it's the same using auth uid
        user = create_devise_user(auth.info.email, auth.info.nickname)
      end

      # give to the authorization the user
      authorization.user = user
    end
    authorization.save!

    authorization.user
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


  # == Instance Methods
  def to_param
    username
  end

  private
  def password_required?
    !persisted? || !password.blank? || !password_confirmation.blank?
  end

  def self.create_devise_user(email, username)
    user = User.new
    user.email = email
    user.username = username || email.split('@').first
    user.password = Devise.friendly_token[0, 20]
    user.save!
    user
  end

  def check_username
    self.username = self.login
    self.username = self.email.split('@').first if self.username.blank?
  end
end
