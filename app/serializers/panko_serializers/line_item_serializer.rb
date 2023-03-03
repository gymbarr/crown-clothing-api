# frozen_string_literal: true

module PankoSerializers
  class LineItemSerializer < Panko::Serializer
    attributes :id, :order_id, :variant_id, :quantity
  end
end
