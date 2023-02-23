# frozen_string_literal: true

module PankoSerializers
  class ProductPgSearchableSerializer < Panko::Serializer
    include Rails.application.routes.url_helpers

    attributes :id, :title, :category, :price, :imageUrl

    def id
      object.searchable_id
    end

    def title
      object.content
    end

    def category
      object.searchable.category.title
    end

    def price
      object.searchable.price
    end

    def imageUrl
      url_for object.searchable.image if object.searchable.image.attached?
    end
  end
end
