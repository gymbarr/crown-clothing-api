# frozen_string_literal: true

require 'rails_helper'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'LineItems', type: :request do
  describe 'DELETE /api/line_items/:id' do
    subject(:delete_line_item_request) do
      delete "/api/line_items/#{line_item.id}", headers:
    end

    let(:line_item) { create(:line_item) }
    let(:user) { create(:user) }

    before do
      create(:order, user:, line_items: [line_item])
      delete_line_item_request
    end

    context 'when authorized user' do
      let(:headers) { user_auth_header(user) }

      it 'decrements the count of line items by 1' do
        expect(LineItem.count).to eq(0)
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
