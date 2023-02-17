class ProductsController < ApplicationController
  before_action :find_category
  before_action :find_product, except: %i[create index]
  before_action :authorize_product!, except: %i[create index]

  # GET /categories/{category}/products
  def index
    authorize(Product)

    @products = @category.products.includes(:variants)
    @available_colors = @products.pluck(:color).uniq
    @available_sizes = @products.pluck(:size).uniq.sort
    @products = @products.where(variants: products_filters_params) if products_filters_params.present?

    @pagy, @products = pagy(@products.order(created_at: :desc), items: params[:items])
    pagy_headers_merge(@pagy)

    render json: Panko::Response.new(
      products: Panko::ArraySerializer.new(@products, each_serializer: PankoSerializers::ProductSerializer),
      filters: {
        colors: @available_colors,
        sizes: @available_sizes
      }
    ), status: :ok
  end

  # GET /categories/{category}/products/{id}
  def show
    render json: PankoSerializers::ProductSerializer.new.serialize(@product), status: :ok
  end

  # GET /categories/{category}/products/{id}/show_variants
  def show_variants
    @available_variants = @product.variants
    if variants_filter_params.blank?
      return render json: PankoSerializers::VariantSerializer.new.serialize(@available_variants), status: :ok
    end

    render json: PankoSerializers::VariantSerializer.new.serialize(@available_variants.where(variants_filter_params)), status: :ok
  end

  # POST /categories/{category}/products
  def create
    authorize(Product)

    @product = Product.new(product_params)
    if @product.save
      render json: PankoSerializers::ProductSerializer.new.serialize(@product), status: :created
    else
      render json: { errors: @product.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /categories/{category}/products/{id}
  def update
    if @product.update(product_params)
      render json: PankoSerializers::ProductSerializer.new.serialize(@product), status: :ok
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
    @product = @category.products.includes(:variants).find(params[:id])
  end

  def product_params
    params.permit(:title, :price, :category_id)
  end

  def products_filters_params
    @products_filters_params ||= params.permit(filters: { color: [], size: [] })[:filters].to_h
  end

  def variants_filter_params
    @variants_filter_params ||= params.permit(attrs: %i[color])[:attrs]
  end

  def authorize_product!
    authorize(@product)
  end
end
