require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'GET /api/category/:title' do
    subject(:get_category_request) { get "/api/categories/#{category.title}" }

    let(:category) { create :category }

    before do
      create_list :product, 3, category: category
      get_category_request
    end

    it 'returns valid JSON' do
      expect(json.length).to eq(3)
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
