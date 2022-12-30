require 'rails_helper'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Users', type: :request do
  describe 'GET /api/users' do
    subject(:get_users_request) { get '/api/users', headers: }

    before do
      get_users_request
    end

    context 'when authorized user' do
      let(:user) { create :user, :with_admin_role }
      let!(:users) { create_list :user, 4 }
      let(:headers) { user_auth_header(user) }
      let!(:users_json) { JSON.parse(ActiveModelSerializers::SerializableResource.new(User.all).to_json) }

      it 'returns a valid JSON' do
        expect(json).to match_array(users_json)
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
