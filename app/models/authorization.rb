class Authorization < ActiveRecord::Base
  # == Validations
  validates :uid, :provider, :token, :presence => true

  # == Associations
  belongs_to :user

  # == Configurations
  serialize :urls, Hash

  # == Instance Methods
  def fetch_info(auth)
    self.token  = auth.credentials.token
    self.secret = auth.credentials.secret

    self.name        = auth.info.name
    self.email       = auth.info.email
    self.nickname    = auth.info.nickname
    self.image       = auth.info.image
    self.description = auth.info.description
    self.urls        = auth.info.urls
    self.location    = auth.info.location
  end
end
