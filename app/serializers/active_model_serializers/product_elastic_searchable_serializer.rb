module ActiveModelSerializers
  class ProductElasticSearchableSerializer < ActiveModel::Serializer
    attributes :title, :price, :category, :imageUrl
  end
end
