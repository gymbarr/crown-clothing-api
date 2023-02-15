require 'rails_helper'

RSpec.describe "Compare searching performance testing" do
  let(:pg_search_query) { PgSearch.multisearch('hat') }
  let(:elastic_search_query) { Searchkick.search('hat', models: [Product, Category], match: :word_start, load: false) }

  let(:category) { create :category }

  before do
    create_list(:product, 10_000, category:)

    PgSearch::Multisearch.rebuild(Category, clean_up: false)
    PgSearch::Multisearch.rebuild(Product, clean_up: false)
    Category.reindex
    Product.reindex
  end

  it 'compares the searching methods' do
    expect { elastic_search_query }.to(perform_slower_than { pg_search_query })
  end
end
