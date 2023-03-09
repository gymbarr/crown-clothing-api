# frozen_string_literal: true

module ActiveModelSerializers
  class LineItemSerializer < ActiveModel::Serializer
    attributes :id, :order_id, :variant_id, :quantity
  end
end
