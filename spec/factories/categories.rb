FactoryBot.define do
  factory :category do
    title { Faker::Alphanumeric.unique.alpha(number: 10) }

    trait :with_products do
      transient do
        products_count { 1 }
        variants_per_product { 0 }
      end

      products do
        create_list(:product, products_count, :with_variants, variants_count: variants_per_product)
      end
    end

    after(:build) do |category|
      category.image.attach(io: Rails.root.join('app/assets/images/categories/hats.png').open, filename: 'hats.png',
                            content_type: 'image/png')
    end
  end
end
