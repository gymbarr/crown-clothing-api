# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PankoSerializers::OrderSerializer, type: :serializer do
  include Rails.application.routes.url_helpers

  describe '.serialize' do
    subject(:order_serializer) { described_class.new.serialize(order).symbolize_keys }

    let(:order) { create(:order, :with_line_items, line_items_count: 2) }

    it 'returns correct keys and values' do
      expect(order_serializer).to include(
        id: order.id,
        user_id: order.user_id,
        total: order.total,
        status: order.status,
        dateCreated: order.created_at.strftime('%e %B %Y'),
        line_items: Panko::ArraySerializer.new(order.line_items.order(:created_at),
                                               each_serializer: PankoSerializers::LineItemSerializer)
                                          .to_a
      )
    end
  end
end
