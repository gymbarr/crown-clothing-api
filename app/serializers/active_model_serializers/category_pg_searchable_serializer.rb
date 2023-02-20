module ActiveModelSerializers
  class CategoryPgSearchableSerializer < ActiveModel::Serializer
    include Rails.application.routes.url_helpers

    attribute :id do
      object.searchable_id
    end

    attribute :title do
      object.content
    end
  end
end
