module PankoSerializers
  class ProductElasticSearchableSerializer < Panko::Serializer
    attributes :title, :price, :category, :imageUrl
  end
end
