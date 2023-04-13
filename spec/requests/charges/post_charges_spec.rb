# frozen_string_literal: true

require 'rails_helper'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Charges', type: :request do
  describe 'POST /api/charges/create' do
    subject(:post_charges_request) do
      post '/api/charges/create', headers:, params:
    end

    let(:user) { create(:user) }
    let(:order) { create(:order, :with_line_items, line_items_count: 3) }
    let(:stripe_checkout) { Stripe::Checkout::Session }
    let(:session) { double }
    let(:session_url) { 'session_url' }
    let(:params) { { order_id: order.id, back_url: 'http://www.localhost:3001/orders' } }

    let(:stripe_line_items) do
      order.line_items.map do |line_item|
        {
          price_data: {
            currency: 'usd',
            unit_amount: line_item.price * 100,
            product_data: {
              name: line_item.title,
              description: "Color: #{line_item.color}, size: #{line_item.size}"
            }
          },
          quantity: line_item.quantity
        }
      end
    end

    before do
      allow(stripe_checkout).to receive(:create).with(
        {
          customer_email: user.email,
          payment_method_types: ['card'],
          line_items: stripe_line_items,
          mode: 'payment',
          metadata: { order_id: order.id },
          success_url: "#{params[:back_url]}?success=true",
          cancel_url: "#{params[:back_url]}?canceled=true",
          expires_at: Time.now.to_i + 3600
        }
      ).and_return(session)
      allow(session).to receive(:url).and_return(session_url)
      post_charges_request
    end

    context 'when authorized user' do
      let(:headers) { user_auth_header(user) }

      it 'creates the stripe checkout session instance' do
        expect(stripe_checkout).to have_received(:create)
      end

      it 'returns session url' do
        expect(json['session']).to eq(session_url)
      end
    end

    context 'when unauthorized user' do
      let(:headers) { {} }

      include_examples 'not authorized'
    end
  end
end
