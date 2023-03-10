# frozen_string_literal: true

require 'rails_helper'
require 'requests/shared_examples/invalid_params_spec'

RSpec.describe 'Users', type: :request do
  describe 'POST /api/users' do
    subject(:post_users_request) do
      post '/api/users', params:
    end

    let(:token) { 'token' }
    let(:service) { Authentications::JsonWebTokenEncoder }

    before do
      allow(service).to receive(:call).and_return(token)
      post_users_request
    end

    context 'with valid parameters' do
      let(:params) { attributes_for(:user) }

      it 'calls the service' do
        expect(service).to have_received(:call)
      end

      it 'returns a token in headers' do
        expect(response.headers['token']).to eq(token)
      end

      it 'returns an email' do
        expect(json['email']).to eq(params[:email])
      end

      it 'returns a username' do
        expect(json['username']).to eq(params[:username])
      end

      it 'returns created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:params) { attributes_for(:user, **attrs) }

      it_behaves_like 'with errors' do
        let(:attrs) { { username: nil } }
        let(:errors) { ['Username can\'t be blank', 'Username is invalid'] }
        let(:status) { :unprocessable_entity }
      end

      it_behaves_like 'with errors' do
        let(:attrs) { { email: nil } }
        let(:errors) { ['Email can\'t be blank', 'Email is invalid'] }
        let(:status) { :unprocessable_entity }
      end

      it_behaves_like 'with errors' do
        let(:attrs) { { password: nil } }
        let(:errors) { ['Password can\'t be blank', 'Password is too short (minimum is 6 characters)'] }
        let(:status) { :unprocessable_entity }
      end
    end
  end
end
