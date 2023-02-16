require 'rails_helper'

RSpec.describe 'Searching methods performance', type: :performance do
  let(:category) { create :category }

  before do
    create_list(:product, 1000, category:)

    PgSearch::Multisearch.rebuild(Category, clean_up: false)
    PgSearch::Multisearch.rebuild(Product, clean_up: false)
    Category.reindex
    Product.reindex
  end

  it 'compares the searching methods' do
    10.times do
      query = ('a'..'z').to_a.sample
      p query
      expect { elastic_search_query(query) }.to(perform_faster_than { pg_search_query(query) })
    end
  end
end
