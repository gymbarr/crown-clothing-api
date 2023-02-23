# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'GET /api/categories/:category_title/products' do
    subject(:get_products_request) { get "/api/categories/#{category.title}/products", params: }

    let(:params) { {} }
    let(:category) { create(:category, :with_products, products_count: 10, variants_per_product: 3) }
    let(:products) { category.products.includes(:variants) }
    let(:available_filters) do
      {
        'colors' => products.distinct.pluck(:color),
        'sizes' => products.distinct.pluck(:size).sort
      }
    end

    before do
      get_products_request
    end

    context 'when products filter parameters present' do
      let(:params) { { filters: { color: [products[0].variants[0].color], size: [products[0].variants[0].size] } } }
      let(:filtered_products) { products.where(variants: params[:filters]) }
      let(:filtered_products_json) do
        JSON.parse(Panko::ArraySerializer.new(filtered_products,
                                              each_serializer: PankoSerializers::ProductSerializer).to_json)
      end

      it 'returns filtered products' do
        expect(json['products']).to match_array(filtered_products_json)
      end
    end

    context 'when products filter parameters does not present' do
      let(:params) { {} }
      let(:products_json) do
        JSON.parse(Panko::ArraySerializer.new(products,
                                              each_serializer: PankoSerializers::ProductSerializer).to_json)
      end

      it 'returns all products' do
        expect(json['products']).to match_array(products_json)
      end
    end

    context 'when products per page parameter present' do
      let(:products_per_page) { 2 }
      let(:params) { { items: products_per_page } }
      let(:products_first_page_json) do
        JSON.parse(Panko::ArraySerializer.new(products.last(products_per_page),
                                              each_serializer: PankoSerializers::ProductSerializer).to_json)
      end

      it 'returns all products' do
        expect(json['products']).to match_array(products_first_page_json)
      end
    end

    it 'returns available filters' do
      expect(json['filters']).to include(available_filters)
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
