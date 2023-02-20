require 'rails_helper'

RSpec.describe ActiveModelSerializers::CategoryElasticSearchableSerializer, type: :serializer do
  describe '.serializable_hash' do
    subject(:category_elastic_searchable_serializer) do
      described_class.new(category_elastic_searchable).serializable_hash
    end

    let!(:category) { create :category }
    let(:category_elastic_searchable) do
      Searchkick.search(
        category.title,
        models: [Category],
        match: :word_start,
        load: false,
        misspellings: false
      )[0]
    end

    before do
      Category.reindex
    end

    it 'returns correct keys and values' do
      expect(category_elastic_searchable_serializer).to include(
        id: category_elastic_searchable.id,
        title: category_elastic_searchable.title
      )
    end
  end
end
