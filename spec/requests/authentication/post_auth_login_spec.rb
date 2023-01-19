require 'rails_helper'
require 'requests/shared_examples/invalid_params_spec'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /api/auth/login' do
    subject(:post_auth_login_request) do
      post '/api/auth/login', params:
    end

    let(:user) { create :user }
    let(:token) { 'token' }
    let(:service) { Authorization::JsonWebTokenEncoder }

    before do
      allow(service).to receive(:call).and_return(token)
      post_auth_login_request
    end

    context 'with valid parameters' do
      let(:params) { { email: user.email, password: user.password } }

      it 'calls the service' do
        expect(service).to have_received(:call).with(user_id: user.id)
      end

      it 'returns a token in headers' do
        expect(response.headers['token']).to eq(token)
      end

      it 'returns a user id' do
        expect(json['id']).to eq(user.id)
      end

      it 'returns an email' do
        expect(json['email']).to eq(user.email)
      end

      it 'returns a username' do
        expect(json['username']).to eq(user.username)
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      let(:params) { { email: user.email, password: user.password, **attrs } }

      it_behaves_like 'with errors' do
        let(:attrs) { { email: nil } }
        let(:errors) { ['Invalid email or password'] }
        let(:status) { :unauthorized }
      end

      it_behaves_like 'with errors' do
        let(:attrs) { { password: nil } }
        let(:errors) { ['Invalid email or password'] }
        let(:status) { :unauthorized }
      end
    end
  end
end
