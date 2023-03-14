# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :find_user
  before_action :find_order, only: %i[show]
  before_action :authorize_order!, only: %i[show]
  skip_after_action :verify_authorized, only: %i[index]

  # GET /users/{username}/orders
  def index
    orders = policy_scope(Order, policy_scope_class: OrderPolicy::UserOrdersScope)

    render json: Panko::Response.new(
      Panko::ArraySerializer.new(orders, each_serializer: PankoSerializers::OrderSerializer)
    ), status: :ok
  end

  # GET /users/{username}/orders/{id}
  def show
    render json: PankoSerializers::OrderSerializer.new.serialize(@order), status: :ok
  end

  # POST /users/{username}/orders
  def create
    authorize(:order, :create?)

    order = @user.orders.build
    order.unpaid!
    order.build_line_items(params[:line_items])

    if order.save
      # does it need to reload?
      order.reload
      render json: PankoSerializers::OrderSerializer.new.serialize(order), status: :ok
    else
      render json: { errors: order.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.find_by!(username: params[:_username])
  end

  def find_order
    @order = @user.orders.find(params[:id])
  end

  def authorize_order!
    authorize(@order)
  end
end
