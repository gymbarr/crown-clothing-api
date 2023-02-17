require 'rails_helper'

RSpec.describe CategorySerializer, type: :serializer do
  include Rails.application.routes.url_helpers

  describe '.serializable_hash' do
    subject(:category_serializer) { described_class.new.serialize(category).symbolize_keys }

    let(:category) { create :category }

    it 'returns correct keys and values' do
      expect(category_serializer).to include(
        id: category.id,
        title: category.title,
        imageUrl: url_for(category.image)
      )
    end
  end
end
