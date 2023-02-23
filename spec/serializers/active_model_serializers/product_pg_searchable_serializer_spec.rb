# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActiveModelSerializers::ProductPgSearchableSerializer, type: :serializer do
  include Rails.application.routes.url_helpers

  describe '.serializable_hash' do
    subject(:product_pg_searchable_serializer) do
      described_class.new(product_pg_searchable).serializable_hash
    end

    let(:product) { create(:product) }
    let(:product_pg_searchable) { PgSearch.multisearch(product.title)[0] }

    it 'returns correct keys and values' do
      expect(product_pg_searchable_serializer).to include(
        id: product_pg_searchable.searchable_id,
        title: product_pg_searchable.content,
        category: product_pg_searchable.searchable.category.title,
        price: product_pg_searchable.searchable.price,
        imageUrl: url_for(product_pg_searchable.searchable.image)
      )
    end
  end
end
