class ResultsController < ApplicationController
  skip_before_action :authorize_request
  skip_after_action :verify_authorized

  def index
    @search_results = Product.search_everywhere(params[:query])

    @pagy, @search_results = pagy_countless(@search_results.order(created_at: :desc))

    render json: {
      products: ActiveModelSerializers::SerializableResource.new(@search_results),
      pagy: pagy_metadata(@pagy)
    }, status: :ok
  end
end
