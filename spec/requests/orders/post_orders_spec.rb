# frozen_string_literal: true

require 'rails_helper'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Orders', type: :request do
  describe 'POST /api/orders' do
    subject(:post_order_request) { post '/api/orders', headers:, params: }

    let(:user) { create(:user) }
    let(:variant) { create(:variant) }
    let(:line_item_quantity) { 5 }
    let(:params) { { line_items: [{ variant_id: variant.id, quantity: line_item_quantity }] } }

    before do
      post_order_request
    end

    context 'when authorized user' do
      let(:headers) { user_auth_header(user) }

      it 'returns the user id' do
        expect(json['user_id']).to eq(user.id)
      end

      it 'returns the total price' do
        expect(json['total']).to eq(variant.price * line_item_quantity)
      end

      it 'returns the status' do
        expect(json['status']).to eq('unpaid')
      end

      it 'returns the date of order creation' do
        expect(json['dateCreated']).to eq(Order.last.created_at.strftime('%e %B %Y'))
      end

      it 'returns the order line items' do
        expect(json['line_items'].size).to eq(params[:line_items].size)
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when unauthorized user' do
      let(:headers) { nil }

      include_examples 'not authorized'
    end
  end
end
