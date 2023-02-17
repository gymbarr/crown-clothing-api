class CategoriesController < ApplicationController
  before_action :find_category, except: %i[create index]
  before_action :authorize_category!, except: %i[create index]

  # GET /categories
  def index
    authorize(Category)

    @categories = Category.all
    render json: Panko::ArraySerializer.new(@categories, each_serializer: CategorySerializer).to_a, status: :ok
  end

  # GET /categories/{category}
  def show
    render json: CategorySerializer.new.serialize(@category), status: :ok
  end

  # POST /categories
  def create
    authorize(Category)

    @category = Category.new(category_params)
    if @category.save
      render json: CategorySerializer.new.serialize(@category), status: :created
    else
      render json: { errors: @category.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /categories/{title}
  def update
    if @category.update(category_params)
      render json: CategorySerializer.new.serialize(@category), status: :ok
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
    @category = Category.find_by!(title: params[:category_title])
  end

  def category_params
    params.permit(:title)
  end

  def authorize_category!
    authorize(@category)
  end
end
