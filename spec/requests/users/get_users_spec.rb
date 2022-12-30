require 'rails_helper'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Users', type: :request do
  describe 'GET /api/users' do
    subject(:get_users_request) { get '/api/users', headers: }

    before do
      create_list :user, 4
      get_users_request
    end

    context 'when authorized user' do
      let(:user) { create :user, :with_admin_role }
      let(:headers) { user_auth_header(user) }

      it 'returns all users' do
        expect(json.size).to eq(User.count)
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
