require 'rails_helper'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Charges', type: :request do
  describe 'POST /api/charges/create' do
    subject(:post_charges_request) do
      post '/api/charges/create', headers:, params:
    end

    let(:user) { create :user }
    let(:stripe_checkout) { Stripe::Checkout::Session }
    let(:session) { instance_double('Session') }
    let(:session_url) { 'session_url' }
    let(:params) { { amount: '50', back_url: 'http://www.localhost:3001/checkout' } }

    before do
      allow(stripe_checkout).to receive(:create).with((
        {
          customer_email: user.email,
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
        }
      )).and_return(session)
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
