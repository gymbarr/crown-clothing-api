require 'rails_helper'
require 'requests/shared_examples/invalid_params_spec'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Products', type: :request do
  describe 'POST /api/categories/:category_title/products' do
    subject(:post_products_request) do
      post "/api/categories/#{category.title}/products", headers:, params:
    end

    let(:category) { create :category }

    before do
      post_products_request
    end

    context 'when authorized user' do
      let(:user) { create :user, :with_admin_role }
      let(:headers) { user_auth_header(user) }

      context 'with valid parameters' do
        let(:params) { attributes_for :product, category_id: category.id }

        it 'returns the product title' do
          expect(json['title']).to eq(params[:title])
        end

        it 'returns the product price' do
          expect(json['price']).to eq(params[:price])
        end

        it 'returns the category title' do
          expect(json['category']).to eq(category.title)
        end

        it 'returns created status' do
          expect(response).to have_http_status(:created)
        end
      end

      context 'with invalid parameters' do
        let(:params) { attributes_for :product, **attrs }

        it_behaves_like 'with errors' do
          let(:attrs) { { title: nil, category_id: category.id } }
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
      let(:params) { nil }

      include_examples 'not authorized'
    end
  end
end
