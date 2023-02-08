class SearchResultsController < ApplicationController
  skip_before_action :authorize_request
  skip_after_action :verify_authorized

  def index
    # sort by rank!!
    @search_results = PgSearch.multisearch(params[:query])
    @categories_searchable = @search_results.where(searchable_type: 'Category').limit(10)

    @pagy, @products_searchable = pagy_countless(@search_results.where(searchable_type: 'Product')
                                                                .order(created_at: :desc))

    render json: {
      categories: ActiveModelSerializers::SerializableResource.new(@categories_searchable,
                                                                   each_serializer: CategorySearchableSerializer),
      products: ActiveModelSerializers::SerializableResource.new(@products_searchable,
                                                                 each_serializer: ProductSearchableSerializer),
      pagy: pagy_metadata(@pagy)
    }, status: :ok
  end
end
