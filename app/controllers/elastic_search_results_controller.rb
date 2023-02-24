# frozen_string_literal: true

require 'benchmark'

class ElasticSearchResultsController < ApplicationController
  skip_after_action :verify_authorized

  # rubocop:disable Metrics/MethodLength
  # GET /elastic_search_results
  def index
    search_results = []
    @categories = []
    @products = []

    performance = Benchmark.measure do
      search_results = Searchkick.search(
        params[:query],
        models: [Product, Category],
        match: :word_start,
        load: false,
        misspellings: false
      )

      search_results.each do |result|
        if result.type == 'Category'
          @categories << result
        elsif result.type == 'Product'
          @products << result
        end
      end

      @pagy, @products = pagy_array(@products)
    end

    response_time = (performance.real * 1000).round(2)

    render json: Panko::Response.new(
      categories: Panko::ArraySerializer.new(@categories,
                                             each_serializer: PankoSerializers::CategoryElasticSearchableSerializer),
      products: Panko::ArraySerializer.new(@products,
                                           each_serializer: PankoSerializers::ProductElasticSearchableSerializer),
      performance: response_time,
      pagy: pagy_metadata(@pagy)
    ), status: :ok
  end
  # rubocop:enable Metrics/MethodLength
end
