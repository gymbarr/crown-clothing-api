require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'GET /api/categories' do
    subject(:get_categories_request) { get '/api/categories' }

    let!(:categories) { create_list :category, 10 }

    before do
      get_categories_request
    end

    it 'returns all categories' do
      expect(json.size).to eq(categories.size)
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
