module PankoSerializers
  class ProductElasticSearchableSerializer < Panko::Serializer
    attributes :id, :title, :price, :category, :imageUrl
  end
end
