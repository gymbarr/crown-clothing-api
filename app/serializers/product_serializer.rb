class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :category_id
  attribute :imageUrl do
    object.image.url
  end
end
