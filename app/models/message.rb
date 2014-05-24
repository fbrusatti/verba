class Message < ActiveRecord::Base
  # == Validations
  validates :user_id, :subject, :body, presence: true
  validates :subject, uniqueness: {scope: :user_id}

  # == Associations
  belongs_to :user
end
