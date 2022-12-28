class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :category_id
  attribute :image_url, key: :imageUrl
end
