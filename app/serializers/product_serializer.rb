class ProductSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :price
  attribute :category do
    object.category.title
  end
  attribute :imageUrl, if: :image_attached? do
    url_for object.image
  end
  attribute :colors do
    object.variants.pluck(:color).uniq
  end
  attribute :sizes do
    object.variants.pluck(:size).uniq
  end

  def image_attached?
    object.image.attached?
  end
end
