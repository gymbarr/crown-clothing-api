# frozen_string_literal: true

class VariantSerializer < ActiveModel::Serializer
  attributes :id, :color, :size
  attribute :title do
    object.title
  end
  attribute :price do
    object.price
  end
end
