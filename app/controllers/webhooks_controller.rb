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
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      puts 'Signature error'
      p e
      return
    end

    binding.pry
    # Handle the event
    case event.type
    when 'checkout.session.completed'
      session = event.data.object
      order = Order.find_by(id: session.metadata.order_id)
      # order.line_items.each { |line_item| line_item.variant.decrement!(:quantity) }
      order.paid!
      order.save!
    end

    render json: { message: 'success' }
  end
end
