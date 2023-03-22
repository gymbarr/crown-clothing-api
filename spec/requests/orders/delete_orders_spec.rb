# frozen_string_literal: true

require 'rails_helper'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Orders', type: :request do
  describe 'DELETE /api/orders/:id' do
    subject(:delete_order_request) do
      delete "/api/orders/#{order.id}", headers:
    end

    let(:order) { create(:order, user:) }
    let(:user) { create(:user) }

    before do
      delete_order_request
    end

    context 'when authorized user' do
      let(:headers) { user_auth_header(user) }

      it 'decrements the count of products by 1' do
        expect(Order.count).to eq(0)
      end

      it 'returns no content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when unauthorized user' do
      include_examples 'not authorized'
    end
  end
end
