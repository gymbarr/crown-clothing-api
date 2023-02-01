# frozen_string_literal: true

class VariantSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :color, :size
  attribute :title do
    object.title
  end
  attribute :price do
    object.price
  end
  attribute :imageUrl do
    url_for object.image
  end
end
