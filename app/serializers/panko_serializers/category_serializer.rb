# frozen_string_literal: true

module PankoSerializers
  class CategorySerializer < Panko::Serializer
    include Rails.application.routes.url_helpers

    attributes :id, :title, :imageUrl

    def imageUrl
      url_for object.image if object.image.attached?
    end
  end
end
