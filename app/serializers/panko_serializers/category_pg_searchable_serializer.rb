module PankoSerializers
  class CategoryPgSearchableSerializer < Panko::Serializer
    include Rails.application.routes.url_helpers

    attributes :id, :title, :imageUrl

    def id
      object.searchable_id
    end

    def title
      object.content
    end

    def imageUrl
      url_for object.searchable.image if object.searchable.image.attached?
    end
  end
end
