require 'rails_helper'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Users', type: :request do
  describe 'GET /api/users' do
    subject(:get_users_request) { get '/api/users', headers: }

    before do
      create_list :user, 21
      get_users_request
    end

    context 'when authorized user' do
      let(:user) { create :user, :with_admin_role }
      let(:headers) { user_auth_header(user) }
      let(:users_per_page) { Pagy::DEFAULT[:items] }
      let(:users_json) do
        JSON.parse(Panko::ArraySerializer.new(User.first(users_per_page), each_serializer: UserSerializer).to_json)
      end

      it 'returns a valid JSON' do
        expect(json['users']).to match_array(users_json)
        expect(json['users'].size).to eq(users_per_page)
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
