# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :find_user, except: %i[show]
  before_action :authorize_order!, only: %i[show]

  # GET /users/{username}/orders
  def index
    authorize(@user, :index?)

    render json: @user.orders
  end

  # GET /users/{username}/orders/{id}
  def show
    render json: @order
  end

  def create; end

  private

  def find_user
    @user = User.find_by!(username: params[:_username])
  end

  def find_order
    @order = Order.find(params[:id])
  end

  def authorize_order!
    authorize(@order)
  end
end
