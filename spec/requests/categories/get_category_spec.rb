require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'GET /api/category/:title' do
    subject(:get_category_request) { get "/api/categories/#{category.title}" }

    let(:category) { create :category }
    let(:products) { create_list :product, 3, category: category }
    let!(:products_json) { JSON.parse(ActiveModelSerializers::SerializableResource.new(products).to_json) }

    before do
      get_category_request
    end

    it 'returns a valid JSON' do
      expect(json).to match_array(products_json)
      expect(json.size).to eq(products.size)
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
