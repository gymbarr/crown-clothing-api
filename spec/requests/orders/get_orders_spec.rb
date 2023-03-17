# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  describe 'GET /api/orders' do
    subject(:get_orders_request) { get '/api/orders', headers: }

    let(:user) { create(:user) }
    let!(:orders) { create_list(:order, 5, user:) }
    let(:headers) { user_auth_header(user) }

    before do
      get_orders_request
    end

    it 'returns all user orders' do
      expect(json.size).to eq(user.orders.size)
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
