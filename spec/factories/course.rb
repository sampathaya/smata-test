FactoryBot.define do
  factory :course do
    name { Faker::Course.name }
    category { create(:category) }
  end
end
