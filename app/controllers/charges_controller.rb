class ChargesController < ApplicationController
  skip_after_action :verify_authorized

  # def create
  #   payment_intent = Stripe::PaymentIntent.create(
  #     amount: params[:amount],
  #     currency: 'usd',
  #     payment_method_types: ['card']
  #   )

  #   render json: { clientSecret: payment_intent['client_secret'] }, status: :ok
  # rescue Stripe => e
  #   render json: { errors: e.messages }, status: :bad_request
  # end

  def create
    session = Stripe::Checkout::Session.create({
                                                 payment_method_types: ['card'],
                                                 line_items: [{
                                                   price_data: {
                                                     currency: 'usd',
                                                     unit_amount: params[:amount],
                                                     product_data: {
                                                       name: 'T-shirt',
                                                       description: 'Comfortable cotton t-shirt',
                                                       images: ['https://example.com/t-shirt.png'],
                                                     }
                                                   },
                                                   quantity: 1
                                                 }],
                                                 mode: 'payment',
                                                 success_url: "#{params[:back_url]}?success=true",
                                                 cancel_url: "#{params[:back_url]}?canceled=true",
                                               })

    render json: { session: session.url }, status: :created
  rescue Stripe => e
    render json: { errors: e.messages }, status: :bad_request
  end
end
