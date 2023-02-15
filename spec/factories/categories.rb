FactoryBot.define do
  factory :category do
    title { Faker::Commerce.department(max: 1) }
  end
end
