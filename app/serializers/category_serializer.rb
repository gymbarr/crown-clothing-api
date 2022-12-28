class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title
  attribute :image_url, key: :imageUrl
end
