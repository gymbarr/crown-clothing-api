# frozen_string_literal: true

FactoryBot.define do
  factory :variant do
    size { Faker::Number.between(from: 1, to: 1000) }
    color { Faker::Alphanumeric.unique.alpha(number: 10) }
    quantity { rand(50..100) }

    association :product
  end
end
