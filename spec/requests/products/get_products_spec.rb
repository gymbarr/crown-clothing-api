require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'GET /api/categories/:category_title/products' do
    subject(:get_products_request) { get "/api/categories/#{category.title}/products", params: }

    let(:category) { create :category }
    let!(:products) { create_list :product, 10, category: category }
    let(:params) { { items: products_per_page } }
    let(:products_per_page) { 2 }
    let(:products_json) do
      JSON.parse(Panko::ArraySerializer.new(Product.last(products_per_page),
                                            each_serializer: PankoSerializers::ProductSerializer).to_json)
    end

    before do
      get_products_request
    end

    it 'returns products of the first page' do
      expect(json['products']).to match_array(products_json)
      expect(json['products'].size).to eq(products_per_page)
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
