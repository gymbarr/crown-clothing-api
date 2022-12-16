require 'rails_helper'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    subject(:get_users_request) { get '/users', headers: }

    let(:users) { create_list(:user, 10) }

    before do
      get_users_request
    end

    context 'when authorized user' do
      let(:headers) { { 'Authorization' => user_token(users.first) } }

      it 'returns all users' do
        expect(json.size).to eq(users.size)
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when unauthorized user' do
      include_examples 'not authorized'
    end
  end
end
