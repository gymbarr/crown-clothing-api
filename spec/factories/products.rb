# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    title { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 1..1000) }

    association :category

    trait :with_variants do
      transient do
        variants_count { 1 }
      end

      variants do
        create_list(:variant, variants_count)
      end
    end

    after(:build) do |product|
      product.image.attach(io: Rails.root.join('app/assets/images/products/hats/brown-brim.png').open,
                           filename: 'brown-brim.png',
                           content_type: 'image/png')
    end
  end
end
