# frozen_string_literal: true

module PankoSerializers
  class OrderSerializer < Panko::Serializer
    attributes :id, :user_id, :total, :status, :dateCreated

    def dateCreated
      object.created_at.strftime('%e %B %Y')
    end
  end
end
