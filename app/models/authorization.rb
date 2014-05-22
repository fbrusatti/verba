class Authorization < ActiveRecord::Base
  # == Validations
  validates :uid, :provider, :token, :presence => true

  # == Associations
  belongs_to :user
end
