FactoryBot.define do
  factory :category do
    title { Faker::Alphanumeric.unique.alpha(number: 10) }

    after(:build) do |category|
      category.image.attach(io: Rails.root.join('app/assets/images/categories/hats.png').open, filename: 'hats.png',
                            content_type: 'image/png')
    end
  end
end
