# frozen_string_literal: true

module ActiveModelSerializers
  class ProductElasticSearchableSerializer < ActiveModel::Serializer
    attribute :id do
      object.id
    end

    attribute :title do
      object.title
    end

    attribute :price do
      object.price
    end

    attribute :category do
      object.category
    end

    attribute :imageUrl do
      object.imageUrl
    end
  end
end
