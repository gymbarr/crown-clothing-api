require 'rails_helper'

RSpec.describe 'ElasticSearchResults', type: :request do
  describe 'GET /api/elastic_search_results' do
    subject(:get_elastic_search_results_request) { get '/api/elastic_search_results', params: }

    let!(:category) { create :category, title: 'some_category' }
    let!(:product) { create :product, category:, title: 'some_product' }
    let(:category_searchable) { { 'id' => category.id.to_s, 'title' => category.title } }
    let(:product_searchable) do
      {
        'id' => product.id.to_s,
        'title' => product.title,
        'category' => product.category.title,
        'price' => product.price,
        'imageUrl' => Rails.application.routes.url_helpers.url_for(product.image)
      }
    end

    before do
      Category.reindex
      Product.reindex
      get_elastic_search_results_request
    end

    context 'when the query satisfies searching condition' do
      let(:params) { { query: 'so' } }

      it 'returns founded category' do
        expect(json['categories']).to contain_exactly(category_searchable)
      end

      it 'returns founded products' do
        expect(json['products']).to contain_exactly(product_searchable)
      end
    end

    context 'when the query does not satisfy searching condition' do
      let(:params) { { query: 'ka' } }

      it 'returns founded category' do
        expect(json['categories']).to be_empty
      end

      it 'returns founded products' do
        expect(json['products']).to be_empty
      end
    end
  end
end
