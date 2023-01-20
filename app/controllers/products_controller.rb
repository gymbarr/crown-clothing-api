class ProductsController < ApplicationController
  before_action :find_category, except: %i[create index]
  before_action :find_product, except: %i[create index]

  # GET /categories/{category}/products
  def index
    @pagy, @products = pagy(@category.products.order(created_at: :desc), items: params[:items])
    pagy_headers_merge(@pagy)
    render json: @products, status: :ok
  end

  # GET /categories/{category}/products/{id}
  def show
    render json: @product, status: :ok
  end

  # POST /categories/{category}/products
  def create
    @product = Product.new(product_params)
    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /categories/{category}/products/{id}
  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: { errors: @product.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /categories/{category}/products/{id}
  def destroy
    @product.destroy
  end

  private

  def find_product
    @product = Product.find(title: params[:id])
  end

  def find_category
    @category = Category.find_by!(title: params[:_title])
  end

  def product_params
    params.permit(:title, :price, :category_id)
  end
end
