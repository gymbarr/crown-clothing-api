FactoryBot.define do
  factory :product do
    title { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 0..1000) }

    association :category
  end
end
