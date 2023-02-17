# frozen_string_literal: true

class VariantSerializer < Panko::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :color, :size, :title, :price, :imageUrl

  delegate :title, :price, to: :object

  def imageUrl
    url_for object.image if object.image.attached?
  end
end
