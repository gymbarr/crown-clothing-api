class ProductElasticSearchableSerializer < Panko::Serializer
  include Rails.application.routes.url_helpers

  attributes :title, :price, :category, :imageUrl
end
