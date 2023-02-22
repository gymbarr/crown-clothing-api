require 'rails_helper'

RSpec.describe ActiveModelSerializers::ProductSerializer, type: :serializer do
  include Rails.application.routes.url_helpers

  describe '.serializable_hash' do
    subject(:product_serializer) { described_class.new(product).serializable_hash }

    let(:product) { create :product }

    it 'returns correct keys and values' do
      expect(product_serializer).to include(
        id: product.id,
        title: product.title,
        price: product.price,
        category: product.category.title,
        imageUrl: url_for(product.image),
        colors: product.variants.pluck(:color).uniq,
        sizes: product.variants.pluck(:size).uniq
      )
    end
  end
end
