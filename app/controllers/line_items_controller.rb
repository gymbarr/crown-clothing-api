class LineItemsController < ApplicationController
  before_action :find_line_item
  before_action :authorize_line_item!

  # POST /line_items/{id}/decrement_quantity
  def decrement_quantity
    @line_item.decrement(:quantity)

    if @line_item.save
      render json: PankoSerializers::LineItemSerializer.new.serialize(@line_item), status: :ok
    else
      render json: { errors: @line_item.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # POST /line_items/{id}/increment_quantity
  def increment_quantity
    @line_item.increment(:quantity)

    if @line_item.save
      render json: PankoSerializers::LineItemSerializer.new.serialize(@line_item), status: :ok
    else
      render json: { errors: @line_item.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /line_items/{id}
  def destroy
    @line_item.destroy
  end

  private

  def find_line_item
    @line_item = LineItem.find(params[:id])
  end

  def authorize_line_item!
    authorize(@line_item)
  end
end
