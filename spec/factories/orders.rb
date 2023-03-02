# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    total { Faker::Commerce.price(range: 0..1000) }
    status { Faker::Alphanumeric.alpha(number: 10) }

    association :user
  end
end
