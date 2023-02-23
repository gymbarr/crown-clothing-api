# frozen_string_literal: true

require 'rails_helper'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Users', type: :request do
  describe 'GET /api/user/me' do
    subject(:get_user_request) { get '/api/user/me', headers: }

    let(:user) { create(:user) }

    before do
      get_user_request
    end

    context 'when authorized user' do
      let(:headers) { user_auth_header(user) }

      it 'returns the username' do
        expect(json['username']).to eq(user.username)
      end

      it 'returns the email' do
        expect(json['email']).to eq(user.email)
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when unauthorized user' do
      it 'returns ok status' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
