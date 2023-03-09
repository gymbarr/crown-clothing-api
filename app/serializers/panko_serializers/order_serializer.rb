# frozen_string_literal: true

module PankoSerializers
  class OrderSerializer < Panko::Serializer
    attributes :id, :user_id, :total, :status, :dateCreated

    has_many :line_items

    def dateCreated
      object.created_at.strftime('%e %B %Y')
    end
  end
end
