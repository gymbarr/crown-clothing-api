require 'rails_helper'

RSpec.describe ActiveModelSerializers::CategoryPgSearchableSerializer, type: :serializer do
  include Rails.application.routes.url_helpers

  describe '.serializable_hash' do
    subject(:category_pg_searchable_serializer) do
      described_class.new(category_pg_searchable).serializable_hash
    end

    let(:category) { create :category }
    let(:category_pg_searchable) { PgSearch.multisearch(category.title)[0] }

    it 'returns correct keys and values' do
      expect(category_pg_searchable_serializer).to include(
        id: category_pg_searchable.searchable_id,
        title: category_pg_searchable.content
      )
    end
  end
end
