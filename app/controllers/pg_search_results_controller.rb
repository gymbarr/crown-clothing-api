require 'benchmark'
include Benchmark

class PgSearchResultsController < ApplicationController
  skip_after_action :verify_authorized

  def index
    ActiveRecord::Base.uncached do
      performance = Benchmark.measure do
        @search_results = PgSearch.multisearch(params[:query])
      end

      @categories_searchable = @search_results.where(searchable_type: 'Category')
      @pagy, @products_searchable = pagy_countless(@search_results.where(searchable_type: 'Product')
                                                                  .order(created_at: :desc))
      response_time = (performance.real * 1000).round(2)

      render json: {
        categories: Panko::ArraySerializer.new(@categories_searchable, each_serializer: CategorySearchableSerializer)
                                          .to_json,
        products: Panko::ArraySerializer.new(@products_searchable, each_serializer: ProductSearchableSerializer)
                                        .to_json,
        performance: response_time,
        pagy: pagy_metadata(@pagy)
      }, status: :ok
    end
  end
end
