# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :find_order, only: %i[show]
  before_action :authorize_order!, only: %i[show]

  # GET /orders
  def index
    authorize(:order, :index?)

    orders = policy_scope(Order, policy_scope_class: OrderPolicy::UserOrdersScope)

    render json: Panko::Response.new(
      Panko::ArraySerializer.new(orders, each_serializer: PankoSerializers::OrderSerializer)
    ), status: :ok
  end

  # GET /orders/{id}
  def show
    render json: PankoSerializers::OrderSerializer.new.serialize(@order), status: :ok
  end

  # POST /orders
  def create
    authorize(:order, :create?)

    order = @current_user.orders.build
    order.unpaid!
    order.build_line_items(params[:line_items])

    if order.save
      render json: PankoSerializers::OrderSerializer.new.serialize(order), status: :ok
    else
      render json: { errors: order.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end

  def authorize_order!
    authorize(@order)
  end
end
