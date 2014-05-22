require 'spec_helper'

describe User do
  # == Associations
  it { should have_many(:authorizations) }
end
