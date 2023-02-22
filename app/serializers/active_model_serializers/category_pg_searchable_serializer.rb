module ActiveModelSerializers
  class CategoryPgSearchableSerializer < ActiveModel::Serializer
    attribute :id do
      object.searchable_id
    end

    attribute :title do
      object.content
    end
  end
end
