# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PankoSerializers::CategoryPgSearchableSerializer, type: :serializer do
  include Rails.application.routes.url_helpers

  describe '.serialize' do
    subject(:category_pg_searchable_serializer) do
      described_class.new.serialize(category_pg_searchable).symbolize_keys
    end

    let(:category) { create(:category) }
    let(:category_pg_searchable) { PgSearch.multisearch(category.title)[0] }

    it 'returns correct keys and values' do
      expect(category_pg_searchable_serializer).to include(
        id: category_pg_searchable.searchable_id,
        title: category_pg_searchable.content
      )
    end
  end
end
