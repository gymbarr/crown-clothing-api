FactoryBot.define do
  factory :product do
    title { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 0..1000) }

    association :category

    after(:build) do |product|
      product.image.attach(io: Rails.root.join('app/assets/images/products/hats/brown-brim.png').open,
                           filename: 'brown-brim.png',
                           content_type: 'image/png')
    end
  end
end
