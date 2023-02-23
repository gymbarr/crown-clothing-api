# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'GET /api/categories/:category_title/products/:id' do
    subject(:get_product_request) { get "/api/categories/#{category.title}/products/#{product.id}" }

    let(:category) { create(:category) }
    let(:product) { create(:product, category:) }

    before do
      get_product_request
    end

    it 'returns the product id' do
      expect(json['id']).to eq(product.id)
    end

    it 'returns the product title' do
      expect(json['title']).to eq(product.title)
    end

    it 'returns the product price' do
      expect(json['price']).to eq(product.price)
    end

    it 'returns the category title' do
      expect(json['category']).to eq(category.title)
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
