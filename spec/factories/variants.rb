# frozen_string_literal: true

FactoryBot.define do
  factory :variant do
    size { Faker::Number.between(from: 30, to: 48) }
    color { Faker::Alphanumeric.unique.alpha(number: 10) }
    quantity { rand(100) }

    association :product
  end
end
