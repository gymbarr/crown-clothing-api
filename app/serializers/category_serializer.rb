class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title
  attribute :imageUrl do
    object.image.url
  end
end
