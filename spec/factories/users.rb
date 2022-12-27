FactoryBot.define do
  factory :user do
    username { Faker::Name.unique.first_name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 6, max_length: 15) }
  end

  trait :with_admin_role do
    roles { create_list(:role, 1, Role.admin_user_role) }
  end
end
