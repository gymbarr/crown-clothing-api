class ProductSearchableSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attribute :id do
    object.searchable_id
  end

  attribute :title do
    object.content
  end

  attribute :category do
    object.searchable.category
  end

  attribute :price do
    object.searchable.price
  end

  attribute :imageUrl do
    url_for object.searchable.image
  end
end
