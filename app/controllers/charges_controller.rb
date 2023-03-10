# frozen_string_literal: true

class ChargesController < ApplicationController
  before_action :find_order

  # rubocop:disable Metrics/MethodLength
  def create
    authorize(:charge, :create?)

    unless @order.prepaid!
      render json: { errors: @order.errors.full_messages },
             status: :bad_request
    end

    session = Stripe::Checkout::Session.create(
      {
        customer_email: @current_user.email,
        payment_method_types: ['card'],
        line_items: stripe_line_items,
        mode: 'payment',
        metadata: { order_id: @order.id },
        success_url: "#{params[:back_url]}?success=true",
        cancel_url: "#{params[:back_url]}?canceled=true"
      }
    )

    render json: { session: session.url }, status: :created
  rescue Stripe => e
    render json: { errors: e.messages }, status: :bad_request
  end
  # rubocop:enable Metrics/MethodLength

  private

  def stripe_line_items
    @order.line_items.map do |line_item|
      product = line_item.variant.product

      {
        price_data: {
          currency: 'usd',
          unit_amount: product.price * 100,
          product_data: {
            name: line_item.title,
            description: "Color: #{line_item.color}, size: #{line_item.size}"
          }
        },
        quantity: line_item.quantity
      }
    end
  end

  def requested_line_items
    params.permit(requested_line_items: %i[variant_id quantity])[:requested_line_items]
  end

  def find_order
    @order = Order.find(params[:order_id])
  end
end
