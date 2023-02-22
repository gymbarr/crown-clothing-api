module PankoSerializers
  class CategoryElasticSearchableSerializer < Panko::Serializer
    attributes :id, :title
  end
end
