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
        categories: ActiveModelSerializers::SerializableResource.new(@categories_searchable,
                                                                     each_serializer: CategorySearchableSerializer),
        products: ActiveModelSerializers::SerializableResource.new(@products_searchable,
                                                                   each_serializer: ProductSearchableSerializer),
        performance: response_time,
        pagy: pagy_metadata(@pagy)
      }, status: :ok
    end
  end
end
