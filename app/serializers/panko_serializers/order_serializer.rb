# frozen_string_literal: true

module PankoSerializers
  class OrderSerializer < Panko::Serializer
    attributes :id, :user_id, :total, :status
  end
end
