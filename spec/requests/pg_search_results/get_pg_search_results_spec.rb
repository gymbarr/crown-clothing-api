require 'rails_helper'

RSpec.describe 'PgSearchResults', type: :request do
  include Rails.application.routes.url_helpers
  Rails.application.routes.default_url_options = { host: 'localhost', port: '3000' }

  describe 'GET /api/pg_search_results' do
    subject(:get_pg_search_results_request) { get '/api/pg_search_results', params: }

    let!(:category) { create :category, title: 'some_category' }
    let!(:product) { create :product, category:, title: 'some_product' }

    before do
      PgSearch::Multisearch.rebuild(Category)
      PgSearch::Multisearch.rebuild(Product)
      get_pg_search_results_request
    end

    context 'when the query satisfies searching condition' do
      let(:params) { { query: 'so' } }
      let(:category_searchable) { { 'id' => category.id, 'title' => category.title } }
      let(:product_searchable) do
        {
          'id' => product.id,
          'title' => product.title,
          'category' => product.category.title,
          'price' => product.price,
          'imageUrl' => url_for(product.image)
        }
      end

      it 'returns founded category' do
        expect(json['categories']).to contain_exactly(category_searchable)
      end

      it 'returns founded products' do
        expect(json['products'][0]).to eq(product_searchable)
      end
    end
  end
end
