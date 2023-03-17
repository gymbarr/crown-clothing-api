# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  describe 'GET /api/orders/:id' do
    subject(:get_order_request) { get "/api/orders/#{order.id}", headers: }

    let(:order) { create(:order, line_items:, user:) }
    let(:user) { create(:user) }
    let(:line_items) { create_list(:line_item, 5) }
    let(:headers) { user_auth_header(user) }

    before do
      get_order_request
    end

    it 'returns the user id' do
      expect(json['user_id']).to eq(user.id)
    end

    it 'returns the total price' do
      expect(json['total']).to eq(order.total)
    end

    it 'returns the status' do
      expect(json['status']).to eq(order.status)
    end

    it 'returns the date of order creation' do
      expect(json['dateCreated']).to eq(order.created_at.strftime('%e %B %Y'))
    end

    it 'returns the order line items' do
      expect(json['line_items'].size).to eq(line_items.size)
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
