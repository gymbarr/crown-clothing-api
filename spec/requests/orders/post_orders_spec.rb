# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  describe 'POST /api/orders' do
    subject(:post_order_request) { post '/api/orders', headers:, params: }

    let(:user) { create(:user) }
    let(:headers) { user_auth_header(user) }
    let(:variant) { create(:variant) }
    let(:line_item_quantity) { 5 }
    let(:params) { { line_items: [{ variant_id: variant.id, quantity: line_item_quantity }] } }

    before do
      post_order_request
    end

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
end
