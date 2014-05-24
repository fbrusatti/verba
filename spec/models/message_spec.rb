require 'spec_helper'

describe Message do
  # == Validations
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:body) }
  it { should validate_uniqueness_of(:subject).scoped_to(:user_id) }

  # == Associations
  it { should belong_to(:user) }
end
