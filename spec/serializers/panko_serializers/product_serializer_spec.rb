# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PankoSerializers::ProductSerializer, type: :serializer do
  include Rails.application.routes.url_helpers

  describe '.serialize' do
    subject(:product_serializer) { described_class.new.serialize(product).symbolize_keys }

    let(:product) { create(:product) }

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
