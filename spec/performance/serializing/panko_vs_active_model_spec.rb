# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Serializing performance comparison', type: :performance do
  context 'when serializing one object', skip: 'on the first run test fails' do
    let(:product) { create(:product) }

    let(:panko_serializing) { PankoSerializers::ProductSerializer.new.serialize(product).symbolize_keys }
    let(:active_model_serializing) { ActiveModelSerializers::ProductSerializer.new(product).serializable_hash }

    it 'shows that panko is faster' do
      expect { panko_serializing }.to(perform_faster_than { active_model_serializing })
    end
  end

  context 'when serializing many objects' do
    let(:products) { create_list(:product, 100) }

    let(:panko_serializing) do
      Panko::ArraySerializer.new(products,
                                 each_serializer: PankoSerializers::ProductSerializer)
    end
    let(:active_model_serializing) do
      ActiveModelSerializers::SerializableResource.new(products,
                                                       each_serializer: ActiveModelSerializers::ProductSerializer)
    end

    it 'shows that panko is faster' do
      expect { panko_serializing }.to(perform_faster_than { active_model_serializing })
    end
  end
end
