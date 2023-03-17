# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :authenticate_request
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
      render json: { message: e.message }, status: :bad_request
      return
    end

    # Handle the event
    case event.type
    when 'checkout.session.completed'
      session = event.data.object
      @order = Order.find_by(id: session.metadata.order_id)

      begin
        ActiveRecord::Base.transaction do
          @order.line_items.each do |line_item|
            variant = line_item.variant
            variant.decrement(:quantity, line_item.quantity)
            variant.save!
          end
          @order.paid!
        end
      rescue ActiveRecord::RecordInvalid => e
        refund_order(e)
      end

      OrderMailer.with(user: @order.user, order: @order)
                 .order_payment_received_email
                 .deliver_later
    end

    render json: { message: 'success' }, status: :ok
  end

  private

  def refund_order(exception)
    @order.refund!

    OrderMailer.with(user: @order.user, variant: exception.record)
               .product_out_of_stock_after_payment_email
               .deliver_later

    render json: { message: exception.message }, status: :unprocessable_entity
  end
end
