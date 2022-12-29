FactoryBot.define do
  factory :category do
    title { Faker::Hipster.unique.word }
  end
end
