class ProductsController < ApplicationController
  before_action :find_category
  before_action :find_product, except: %i[create index]
  before_action :check_category_equality, except: %i[create index]
  before_action :authorize_product!, except: %i[create index]

  # GET /categories/{category}/products
  def index
    authorize(Product)

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
    authorize(Product)

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

  def find_category
    @category = Category.find_by!(title: params[:category_title])
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def check_category_equality
    raise ActiveRecord::RecordNotFound unless @product.category == @category
  end

  def product_params
    params.permit(:title, :price, :category_id)
  end

  def authorize_product!
    authorize(@product)
  end
end
