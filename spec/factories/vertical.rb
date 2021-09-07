FactoryBot.define do
  factory :vertical do
    name { Faker::Name.unique.name }
    user { create(:user) }
  end
end
