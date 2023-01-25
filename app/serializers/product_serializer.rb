class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :price
  attribute :category do
    object.category.title
  end
  attribute :imageUrl do
    object.image.url
  end
end
