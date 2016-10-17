require 'rails_helper'

describe Project do
  it { should have_many(:tasks).dependent(:destroy) }
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(255) }
end
