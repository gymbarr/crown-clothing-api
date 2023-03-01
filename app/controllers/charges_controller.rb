# frozen_string_literal: true

class ChargesController < ApplicationController
  # rubocop:disable Metrics/MethodLength
  def create
    authorize(:charge, :create?)

    session = Stripe::Checkout::Session.create({
                                                 customer_email: @current_user.email,
                                                 payment_method_types: ['card'],
                                                 line_items:,
                                                 mode: 'payment',
                                                 success_url: "#{params[:back_url]}?success=true",
                                                 cancel_url: "#{params[:back_url]}?canceled=true"
                                               })

    render json: { session: session.url }, status: :created
  rescue Stripe => e
    render json: { errors: e.messages }, status: :bad_request
  end
  # rubocop:enable Metrics/MethodLength

  private

  def line_items
    purchases.map do |purchase|
      variant = Variant.find(purchase['variant_id'])
      product = variant.product

      {
        price_data: {
          currency: 'usd',
          unit_amount: product.price,
          product_data: {
            name: product.title,
            description: "Color: #{variant.color}, size: #{variant.size}"
          }
        },
        quantity: purchase['quantity']
      }
    end
  end

  def purchases
    params.permit(purchases: %i[variant_id quantity])[:purchases]
  end
end
