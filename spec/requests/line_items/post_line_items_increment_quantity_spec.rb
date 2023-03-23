# frozen_string_literal: true

require 'rails_helper'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'LineItems', type: :request do
  describe 'POST /api/line_items/:id/increment_quantity' do
    subject(:post_line_items_increment_quantity_request) do
      post "/api/line_items/#{line_item.id}/increment_quantity", headers:
    end

    let(:user) { create(:user) }
    let(:variant) { create(:variant, quantity: 5) }
    let(:line_item) { create(:line_item, variant:, quantity: old_quantity) }
    let(:old_quantity) { 3 }
    let(:line_item_json) do
      JSON.parse(PankoSerializers::LineItemSerializer.new.serialize(line_item.reload).to_json)
    end

    before do
      create(:order, user:, line_items: [line_item])
      post_line_items_increment_quantity_request
    end

    context 'when authorized user' do
      let(:headers) { user_auth_header(user) }

      context 'when available quantity is enough' do
        it 'increments the line item quantity' do
          expect(line_item.reload.quantity).to eq(old_quantity + 1)
        end

        it 'returns valid json' do
          expect(json).to eq(line_item_json)
        end
      end

      context 'when available quantity is not enough' do
        let(:old_quantity) { 5 }

        it 'does not change the line item quantity' do
          expect(line_item.reload.quantity).to eq(old_quantity)
        end

        it 'returns json with error' do
          expect(json['errors']).to match(["Quantity #{variant.title} is out of stock, just #{variant.quantity} left"])
        end
      end
    end

    context 'when unauthorized user' do
      include_examples 'not authorized'
    end
  end
end
