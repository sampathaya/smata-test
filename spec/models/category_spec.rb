require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should belong_to(:vertical) }
  it { should validate_presence_of(:name) }
  it { should belong_to(:vertical) }
  it { should validate_length_of(:name).is_at_least(3) }
end
