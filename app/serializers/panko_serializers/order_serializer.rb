# frozen_string_literal: true

module PankoSerializers
  class OrderSerializer < Panko::Serializer
    attributes :id, :user_id, :total, :status, :dateCreated

    has_many :line_items_sorted_by_created_at, name: :line_items, each_serializer: LineItemSerializer

    def dateCreated
      object.created_at.strftime('%e %B %Y')
    end
  end
end
