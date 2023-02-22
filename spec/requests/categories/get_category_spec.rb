require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'GET /api/categories/:category_title' do
    subject(:get_category_request) { get "/api/categories/#{category.title}" }

    let(:category) { create(:category) }

    before do
      get_category_request
    end

    it 'returns the title' do
      expect(json['title']).to eq(category.title)
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
