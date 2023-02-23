# frozen_string_literal: true

module PankoSerializers
  class CategoryElasticSearchableSerializer < Panko::Serializer
    attributes :id, :title
  end
end
