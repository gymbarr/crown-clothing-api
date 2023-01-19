require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'GET /api/category/:title' do
    subject(:get_category_request) { get "/api/categories/#{category.title}", params: }

    let(:category) { create :category }
    let!(:products) { create_list :product, 10, category: category }
    let(:params) { { items: products_per_page } }
    let(:products_per_page) { 2 }
    let(:products_json) do
      JSON.parse(ActiveModelSerializers::SerializableResource.new(Product.last(products_per_page)).to_json)
    end

    before do
      get_category_request
    end

    it 'returns a valid JSON' do
      expect(json).to match_array(products_json)
      expect(json.size).to eq(products_per_page)
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
