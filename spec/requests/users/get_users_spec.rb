require 'rails_helper'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Users', type: :request do
  describe 'GET /api/users' do
    subject(:get_users_request) { get '/api/users', headers: }

    let!(:users) { create_list :user, 9 }
    let!(:user) { create :user, :with_admin_role }

    before do
      get_users_request
    end

    context 'when authorized user' do
      let(:headers) { user_auth_header(user) }

      it 'returns all users' do
        expect(json.size).to eq(users.size + 1)
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
