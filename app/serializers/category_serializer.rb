class CategorySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title

  attribute :imageUrl do
    url_for object.image
  end
end
