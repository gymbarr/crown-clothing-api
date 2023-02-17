module PankoSerializers
  class ProductSerializer < Panko::Serializer
    include Rails.application.routes.url_helpers

    attributes :id, :title, :price, :category, :imageUrl, :colors, :sizes

    def category
      object.category.title
    end

    def imageUrl
      url_for object.image if object.image.attached?
    end

    def colors
      object.variants.pluck(:color).uniq
    end

    def sizes
      object.variants.pluck(:size).uniq
    end
  end
end
