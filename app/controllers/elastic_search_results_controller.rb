require 'benchmark'

class ElasticSearchResultsController < ApplicationController
  skip_after_action :verify_authorized

  def index
    performance = Benchmark.measure do
      @search_results = Elasticsearch::Model.search("#{params[:query]}*", [], { size: 10000 }).records.to_a

      @categories = @search_results.select { |result| result.class.name == 'Category' }

      @pagy, @products = pagy_array(@search_results.select { |result| result.class.name == 'Product' })
    end

    response_time = (performance.real * 1000).round(2)

    render json: {
      categories: ActiveModelSerializers::SerializableResource.new(@categories),
      products: ActiveModelSerializers::SerializableResource.new(@products),
      performance: response_time,
      pagy: pagy_metadata(@pagy)
    }, status: :ok
  end
end
