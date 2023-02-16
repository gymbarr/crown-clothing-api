require 'benchmark'

class ElasticSearchResultsController < ApplicationController
  skip_after_action :verify_authorized

  def index
    search_results = []
    performance = Benchmark.measure do
      search_results = Searchkick.search(
        params[:query],
        models: [Product, Category],
        match: :word_start,
        load: false,
        misspellings: false
      )
    end

    @categories = search_results.select { |result| result.type == 'Category' }
    @pagy, @products = pagy_array(search_results.select { |result| result.type == 'Product' })
    response_time = (performance.real * 1000).round(2)

    render json: {
      categories: @categories,
      products: @products,
      performance: response_time,
      pagy: pagy_metadata(@pagy)
    }, status: :ok
  end
end
