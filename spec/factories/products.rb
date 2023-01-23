FactoryBot.define do
  factory :product do
    title { Faker::Alphanumeric.alpha(number: 10) }
    price { Faker::Number.between(from: 20, to: 1000) }

    association :category
  end
end
