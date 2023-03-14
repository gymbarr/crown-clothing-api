# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :authorize_request
  skip_after_action :verify_authorized

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, ENV.fetch('STRIPE_ENDPOINT_SECRET')
      )
    rescue JSON::ParserError, Stripe::SignatureVerificationError => e
      render json: { message: e }, status: :bad_request
      return
    end

    # Handle the event
    case event.type
    when 'checkout.session.completed'
      ActiveRecord::Base.transaction do
        session = event.data.object
        order = Order.find_by(id: session.metadata.order_id)
        order.line_items.each do |line_item|
          variant = line_item.variant
          variant.decrement(:quantity, line_item.quantity)

          raise StandardError, variant.errors.full_messages unless variant.valid?

          variant.save
        end
        order.paid!
        order.save!
      end
    end

    render json: { message: 'success' }
  end
end
