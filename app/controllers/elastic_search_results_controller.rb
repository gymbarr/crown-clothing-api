class ElasticSearchResultsController < ApplicationController
  skip_after_action :verify_authorized

  def index
    @search_results = Elasticsearch::Model.search("#{params[:query]}*", [], { size: 100 }).records.to_a

    @categories = @search_results.select { |result| result.class.name == 'Category' }

    @pagy, @products = pagy_array(@search_results.select { |result| result.class.name == 'Product' })

    render json: {
      categories: ActiveModelSerializers::SerializableResource.new(@categories),
      products: ActiveModelSerializers::SerializableResource.new(@products),
      pagy: pagy_metadata(@pagy)
    }, status: :ok
  end
end
