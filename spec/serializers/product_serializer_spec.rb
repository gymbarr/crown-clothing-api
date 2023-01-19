require 'rails_helper'

RSpec.describe ProductSerializer, type: :serializer do
  describe '.serializable_hash' do
    subject(:product_serializer) { described_class.new(product).serializable_hash }

    let(:product) { create :product }

    it 'returns correct keys and values' do
      expect(product_serializer).to include(
        id: product.id,
        title: product.title,
        price: product.price,
        category_id: product.category_id,
        imageUrl: product.image.url
      )
    end
  end
end
