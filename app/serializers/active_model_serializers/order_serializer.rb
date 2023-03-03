# frozen_string_literal: true

module ActiveModelSerializers
  class OrderSerializer < ActiveModel::Serializer
    attributes :id, :user_id, :total, :status
  end
end
