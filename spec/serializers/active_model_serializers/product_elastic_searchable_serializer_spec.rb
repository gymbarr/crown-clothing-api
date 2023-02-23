# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActiveModelSerializers::ProductElasticSearchableSerializer, type: :serializer do
  describe '.serializable_hash' do
    subject(:product_elastic_searchable_serializer) do
      described_class.new(product_elastic_searchable).serializable_hash
    end

    let!(:product) { create(:product) }
    let(:product_elastic_searchable) do
      Searchkick.search(
        product.title,
        models: [Product],
        match: :word_start,
        load: false,
        misspellings: false
      )[0]
    end

    before do
      Product.reindex
    end

    it 'returns correct keys and values' do
      expect(product_elastic_searchable_serializer).to include(
        id: product_elastic_searchable.id,
        title: product_elastic_searchable.title,
        price: product_elastic_searchable.price,
        category: product_elastic_searchable.category,
        imageUrl: product_elastic_searchable.imageUrl
      )
    end
  end
end
