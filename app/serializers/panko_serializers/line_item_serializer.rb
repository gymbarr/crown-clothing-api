# frozen_string_literal: true

module PankoSerializers
  class LineItemSerializer < Panko::Serializer
    include Rails.application.routes.url_helpers

    attributes :id, :order_id, :variant_id, :quantity, :title, :price, :color, :size, :imageUrl

    delegate :title, :price, :color, :size, to: :object

    def imageUrl
      url_for object.image if object.image.attached?
    end
  end
end
