class ChargesController < ApplicationController
  skip_before_action :authorize_request
  skip_after_action :verify_authorized

  def create
    payment_intent = Stripe::PaymentIntent.create(
      amount: params[:amount],
      currency: 'usd',
      payment_method_types: ['card']
    )

    render json: { clientSecret: payment_intent['client_secret'] }, status: :ok
  rescue Stripe => e
    render json: { errors: e.messages }, status: :bad_request
  end
end
