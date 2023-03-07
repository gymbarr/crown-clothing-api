# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    total { 0 }
    status { 'unpaid' }

    association :user

    trait :with_line_items do
      transient do
        line_items_count { 1 }
      end

      line_items do
        create_list(:line_item, line_items_count)
      end
    end
  end
end
