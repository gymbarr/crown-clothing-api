# frozen_string_literal: true

FactoryBot.define do
  factory :line_item do
    quantity { rand(1..10) }
    price { 0 }

    association :order
    association :variant
  end
end
