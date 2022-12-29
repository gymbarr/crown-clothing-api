require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'GET /api/category/:title' do
    subject(:get_category_request) { get "/api/categories/#{category.title}" }

    let!(:category) { create :category }
    let!(:products) { create_list :product, 10, category: category }

    before do
      get_category_request
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
