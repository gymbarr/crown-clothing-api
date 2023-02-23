# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PankoSerializers::VariantSerializer, type: :serializer do
  include Rails.application.routes.url_helpers

  describe '.serialize' do
    subject(:variant_serializer) { described_class.new.serialize(variant).symbolize_keys }

    let(:variant) { create(:variant) }

    it 'returns correct keys and values' do
      expect(variant_serializer).to include(
        id: variant.id,
        color: variant.color,
        title: variant.title,
        price: variant.price,
        imageUrl: url_for(variant.image)
      )
    end
  end
end
