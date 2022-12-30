FactoryBot.define do
  factory :category do
    title { Faker::Alphanumeric.unique.alpha(number: 15) }
  end
end
