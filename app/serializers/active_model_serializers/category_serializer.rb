# frozen_string_literal: true

module ActiveModelSerializers
  class CategorySerializer < ActiveModel::Serializer
    include Rails.application.routes.url_helpers

    attributes :id, :title

    attribute :imageUrl, if: :image_attached? do
      url_for object.image
    end

    def image_attached?
      object.image.attached?
    end
  end
end
