FactoryBot.define do
  factory :product do
    title { Faker::Book.title }
    price { Faker::Number.between(from: 20, to: 1000) }

    association :category

      # categories do
      #   create_list(:category, categories_count, :with_subscribers, subscribers_count: subscribers_per_category)
      # end
  end
end
