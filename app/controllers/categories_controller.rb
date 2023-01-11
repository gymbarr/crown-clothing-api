class CategoriesController < ApplicationController
  before_action :find_category, except: %i[create index]
  before_action :authorize_category!, except: %i[create index]

  # GET /categories
  def index
    authorize(Category)

    @categories = Category.all
    render json: @categories, status: :ok
  end

  # GET /categories/{category}
  def show
    @pagy, @products = pagy(@category.products.order(created_at: :desc), items: params[:items])
    pagy_headers_merge(@pagy)
    render json: @products, status: :ok
  end

  # POST /categories
  def create
    authorize(Category)

    @category = Category.new(category_params)
    if @category.save
      render json: @category, status: :created
    else
      render json: { errors: @category.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /categories/{title}
  def update
    if @category.update(category_params)
      render json: @category, status: :ok
    else
      render json: { errors: @category.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /categories/{title}
  def destroy
    @category.destroy
  end

  private

  def find_category
    @category = Category.find_by!(title: params[:_title])
  end

  def category_params
    params.permit(:title)
  end

  def authorize_category!
    authorize(@category)
  end
end
