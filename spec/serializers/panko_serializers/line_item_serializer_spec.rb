# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PankoSerializers::LineItemSerializer, type: :serializer do
  include Rails.application.routes.url_helpers

  describe '.serialize' do
    subject(:line_item_serializer) { described_class.new.serialize(line_item).symbolize_keys }

    let(:line_item) { create(:line_item) }

    it 'returns correct keys and values' do
      expect(line_item_serializer).to include(
        id: line_item.id,
        order_id: line_item.order_id,
        variant_id: line_item.variant_id,
        quantity: line_item.quantity,
        title: line_item.title,
        price: line_item.price,
        color: line_item.color,
        size: line_item.size,
        imageUrl: url_for(line_item.image)
      )
    end
  end
end
