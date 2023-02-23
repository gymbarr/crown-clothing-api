# frozen_string_literal: true

require 'benchmark'

class PgSearchResultsController < ApplicationController
  include Benchmark
  skip_after_action :verify_authorized

  # GET /pg_search_results
  def index
    ActiveRecord::Base.uncached do
      performance = Benchmark.measure do
        @search_results = PgSearch.multisearch(params[:query])
      end

      @categories_searchable = @search_results.where(searchable_type: 'Category')
      @pagy, @products_searchable = pagy_countless(@search_results.where(searchable_type: 'Product')
                                                                  .order(created_at: :desc))
      response_time = (performance.real * 1000).round(2)

      render json: Panko::Response.new(
        categories: Panko::ArraySerializer.new(@categories_searchable,
                                               each_serializer: PankoSerializers::CategoryPgSearchableSerializer),
        products: Panko::ArraySerializer.new(@products_searchable,
                                             each_serializer: PankoSerializers::ProductPgSearchableSerializer),
        performance: response_time,
        pagy: pagy_metadata(@pagy)
      ), status: :ok
    end
  end
end
