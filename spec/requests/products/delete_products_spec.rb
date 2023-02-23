# frozen_string_literal: true

require 'rails_helper'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Products', type: :request do
  describe 'DELETE /api/categories/:category_title/products/:id' do
    subject(:delete_product_request) do
      delete "/api/categories/#{category.title}/products/#{product.id}", headers:
    end

    let(:category) { create(:category) }
    let(:product) { create(:product, category:) }

    before do
      delete_product_request
    end

    context 'when authorized user' do
      let(:user) { create(:user, :with_admin_role) }
      let(:headers) { user_auth_header(user) }

      it 'decrements the count of products by 1' do
        expect(Product.count).to eq(0)
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
