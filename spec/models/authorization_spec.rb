require 'spec_helper'

describe Authorization do
  # == Validations
  it { should validate_presence_of :uid }
  it { should validate_presence_of :provider }
  it { should validate_presence_of :token }

  # == Associations
  it { should belong_to(:user) }
end
