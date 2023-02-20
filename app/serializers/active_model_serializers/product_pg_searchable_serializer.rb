module ActiveModelSerializers
  class ProductPgSearchableSerializer < ActiveModel::Serializer
    include Rails.application.routes.url_helpers

    attribute :id do
      object.searchable_id
    end

    attribute :title do
      object.content
    end

    attribute :category do
      object.searchable.category.title
    end

    attribute :price do
      object.searchable.price
    end

    attribute :imageUrl do
      url_for object.searchable.image if object.searchable.image.attached?
    end
  end
end
