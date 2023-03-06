# frozen_string_literal: true

class EnoughVariantsValidator < ActiveModel::Validator
  def validate(record)
    record.line_items.each do |line_item|
      variant = line_item.variant
      if line_item.quantity > variant.quantity
        record.errors.add(:line_item, :invalid,
                          message: "#{variant.title} is out of stock, just #{variant.quantity} left")
      end
    end
  end
end
