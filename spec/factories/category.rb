FactoryBot.define do
  factory :category do
    name { Faker::Name.unique.name }
    vertical { create(:vertical) }
  end
end
