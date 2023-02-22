module ActiveModelSerializers
  class CategoryElasticSearchableSerializer < ActiveModel::Serializer
    attribute :id do
      object.id
    end

    attribute :title do
      object.title
    end
  end
end
