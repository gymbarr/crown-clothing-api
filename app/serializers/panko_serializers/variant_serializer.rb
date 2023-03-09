# frozen_string_literal: true

module PankoSerializers
  class VariantSerializer < Panko::Serializer
    include Rails.application.routes.url_helpers

    attributes :id, :color, :size, :availableQuantity, :title, :price, :imageUrl

    delegate :title, :price, to: :object

    def availableQuantity
      object.quantity
    end

    def imageUrl
      url_for object.image if object.image.attached?
    end
  end
end
