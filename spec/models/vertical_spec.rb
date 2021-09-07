require 'rails_helper'

RSpec.describe Vertical, type: :model do
  it { should have_many(:categories) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(3) }
  it { should belong_to(:user) }
end
