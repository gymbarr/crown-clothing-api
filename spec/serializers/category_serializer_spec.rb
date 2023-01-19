require 'rails_helper'

RSpec.describe CategorySerializer, type: :serializer do
  describe '.serializable_hash' do
    subject(:category_serializer) { described_class.new(category).serializable_hash }

    let(:category) { create :category }

    it 'returns correct keys and values' do
      expect(category_serializer).to include(
        id: category.id,
        title: category.title,
        imageUrl: category.image.url
      )
    end
  end
end
