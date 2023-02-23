# frozen_string_literal: true

module PankoSerializers
  class CategoryPgSearchableSerializer < Panko::Serializer
    attributes :id, :title

    def id
      object.searchable_id
    end

    def title
      object.content
    end
  end
end
