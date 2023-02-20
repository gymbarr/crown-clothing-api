FactoryBot.define do
  factory :variant do
    size { Faker::Number.between(from: 30, to: 48) }
    color { Faker::Color.color_name }

    association :product
  end
end
