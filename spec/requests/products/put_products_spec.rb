# frozen_string_literal: true

require 'rails_helper'
require 'requests/shared_examples/invalid_params_spec'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Products', type: :request do
  describe 'PUT /api/categories/:category_title/products/:id' do
    subject(:put_product_request) do
      put "/api/categories/#{category.title}/products/#{product.id}",
          params: new_params,
          headers:
    end

    let(:category) { create(:category) }
    let(:product) { create(:product, category:) }
    let(:new_category) { create(:category) }

    before do
      put_product_request
    end

    context 'when authorized user' do
      let(:user) { create(:user, :with_admin_role) }
      let(:headers) { user_auth_header(user) }

      context 'with valid parameters' do
        let(:new_params) { attributes_for(:product, category_id: new_category.id) }

        it 'changes the product title' do
          expect(product.reload.title).to eq(new_params[:title])
        end

        it 'changes the product price' do
          expect(product.reload.price).to eq(new_params[:price])
        end

        it 'changes the product category id' do
          expect(product.reload.category_id).to eq(new_params[:category_id])
        end

        it 'returns ok status' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'with invalid parameters' do
        let(:new_params) { attributes_for(:product, **attrs) }

        it_behaves_like 'with errors' do
          let(:attrs) { { title: nil } }
          let(:errors) { ['Title can\'t be blank', 'Title is too short (minimum is 3 characters)'] }
          let(:status) { :unprocessable_entity }
        end

        it_behaves_like 'with errors' do
          let(:attrs) { { category_id: nil } }
          let(:errors) { ['Category must exist'] }
          let(:status) { :unprocessable_entity }
        end
      end
    end

    context 'when unauthorized user' do
      let(:new_params) { attributes_for(:product) }

      include_examples 'not authorized'
    end
  end
end
