# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Webhooks', type: :request do
  describe 'POST /api/webhooks/create' do
    subject(:post_webhooks_request) do
      post '/api/webhooks/create'
    end

    let(:user) { create(:user) }
    let(:order) { create(:order, :with_line_items, line_items_count: 3) }
    let(:stripe_webhook) { Stripe::Webhook }
    let(:event) { double }

    before do
      allow(stripe_webhook).to receive(:construct_event).and_return(event)
    end

    context 'when event type is completed' do
      let(:event_success_type) { 'checkout.session.completed' }
      let(:session) { double }
      let(:order) { create(:order, line_items:) }
      let(:variant) { create(:variant, quantity: 5) }
      let(:line_items) { create_list(:line_item, 1, variant:, quantity: 4) }

      before do
        allow(event).to receive(:type).and_return(event_success_type)
        allow(event).to receive_message_chain(:data, :object).and_return(session)
        allow(session).to receive_message_chain(:metadata, :order_id).and_return(order.id)
      end

      context 'when line item quantity is less than available' do
        it 'decrements variant quantity by line item quantity' do
          expect { post_webhooks_request }.to change { variant.reload.quantity }.from(5).to(1)
        end

        it 'changes order status to paid' do
          expect { post_webhooks_request }.to change { order.reload.status }.from('unpaid').to('paid')
        end

        it 'enqueues OrderMailer with order_payment_received_email method' do
          expect { post_webhooks_request }
            .to have_enqueued_mail(
              OrderMailer, :order_payment_received_email
            ).with(hash_including(params: { user: order.user,
                                            order: }))
            .on_queue(:default)
        end

        it 'returns success message' do
          post_webhooks_request
          expect(json['message']).to eq('success')
        end

        it 'returns ok status' do
          post_webhooks_request
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when line item quantity is more than available' do
        before do
          variant.decrement(:quantity, 3)
          variant.save
        end

        it 'does not change variant quantity' do
          expect { post_webhooks_request }.not_to(change { variant.reload.quantity })
        end

        it 'changes order status to refunded' do
          expect { post_webhooks_request }.to change { order.reload.status }.from('unpaid').to('refunded')
        end

        it 'enqueues OrderMailer with product_out_of_stock_after_payment_email method' do
          expect { post_webhooks_request }
            .to have_enqueued_mail(
              OrderMailer, :product_out_of_stock_after_payment_email
            ).with(hash_including(params: { user: order.user,
                                            variant: }))
            .on_queue(:default)
        end

        it 'returns success message' do
          post_webhooks_request
          expect(json['message']).to eq('Validation failed: Quantity must be greater than or equal to 0')
        end

        it 'returns unprocessable entity status' do
          post_webhooks_request
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
