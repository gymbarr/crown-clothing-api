# frozen_string_literal: true

class ChargesController < ApplicationController
  def create
    authorize(:charge, :create?)

    session = Stripe::Checkout::Session.create({
                                                 customer_email: @current_user.email,
                                                 payment_method_types: ['card'],
                                                 line_items: [{
                                                   price_data: {
                                                     currency: 'usd',
                                                     unit_amount: params[:amount],
                                                     product_data: {
                                                       name: 'Crown clothing'
                                                     }
                                                   },
                                                   quantity: 1
                                                 }],
                                                 mode: 'payment',
                                                 success_url: "#{params[:back_url]}?success=true",
                                                 cancel_url: "#{params[:back_url]}?canceled=true"
                                               })

    render json: { session: session.url }, status: :created
  rescue Stripe => e
    render json: { errors: e.messages }, status: :bad_request
  end
end
