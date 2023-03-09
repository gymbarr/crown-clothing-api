# frozen_string_literal: true

class EnoughVariantsValidator < ActiveModel::Validator
  def validate(record)
    record.line_items.each do |item|
      variant = item.variant
      if item.quantity > variant.quantity
        record.errors.add(:line_items, :invalid,
                          message: "#{variant.title} is out of stock, just #{variant.quantity} left")
      end
    end
  end
end
