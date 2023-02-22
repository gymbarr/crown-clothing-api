require 'rails_helper'

RSpec.describe 'Searching methods performance comparison', type: :performance do
  let(:category) { create(:category) }

  before do
    create_list(:product, 1000, category:)

    PgSearch::Multisearch.rebuild(Category)
    PgSearch::Multisearch.rebuild(Product)
    Category.reindex
    Product.reindex
  end

  it 'shows that elastic search is faster' do
    10.times do
      query = ('a'..'z').to_a.sample
      p query
      expect { elastic_search_query(query) }.to(perform_faster_than { pg_search_query(query) })
    end
  end
end
