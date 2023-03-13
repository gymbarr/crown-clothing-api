# frozen_string_literal: true

class ChargesController < ApplicationController
  before_action :find_order

  # rubocop:disable Metrics/MethodLength
  def create
    authorize(:charge, :create?)

    errors = []

    @order.line_items.each do |line_item|
      variant = line_item.variant
      if line_item.quantity > variant.quantity
        errors << "#{variant.title} is out of stock, just #{variant.quantity} left"
      end
    end

    return render json: { errors: }, status: :bad_request if errors

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
