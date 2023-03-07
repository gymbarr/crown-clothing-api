# frozen_string_literal: true

module ActiveModelSerializers
  class OrderSerializer < ActiveModel::Serializer
    attributes :id, :user_id, :total, :status

    attribute :dateCreated do
      object.created_at.strftime('%e %B %Y')
    end
  end
end
