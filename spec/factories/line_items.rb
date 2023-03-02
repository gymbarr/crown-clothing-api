# frozen_string_literal: true

FactoryBot.define do
  factory :line_item do
    quantity { rand(5) }

    association :order
    association :product
  end
end
