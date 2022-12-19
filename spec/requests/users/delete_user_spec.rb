require 'rails_helper'
require 'requests/shared_examples/invalid_params_spec'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Users', type: :request do
  describe 'DELETE /users/:username' do
    subject(:delete_user_request) do
      delete "/users/#{user.username}", headers:
    end

    let(:user) { create :user }

    before do
      delete_user_request
    end

    context 'when authorized user' do
      let(:headers) { user_auth_header(user) }

      it 'decrement the count of users by 1' do
        expect(User.all.count).to eq(0)
      end

      it 'returns no content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when unauthorized user' do
      include_examples 'not authorized'
    end
  end
end
