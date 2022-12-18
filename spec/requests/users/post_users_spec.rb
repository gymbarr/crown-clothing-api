require 'rails_helper'
require 'requests/shared_examples/invalid_params_spec'

RSpec.describe 'Users', type: :request do
  describe 'POST /users' do
    subject(:post_users_request) do
      post '/users', params:
    end

    before do
      post_users_request
    end

    context 'with valid parameters' do
      let(:params) { attributes_for :user }

      it 'returns username' do
        expect(json['username']).to eq(params[:username])
      end

      it 'returns email' do
        expect(json['email']).to eq(params[:email])
      end

      it 'returns created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:params) { attributes_for :user, **attrs }

      it_behaves_like 'with errors' do
        let(:attrs) { { username: nil } }
        let(:errors) { ['Username can\'t be blank', 'Username is invalid'] }
      end

      it_behaves_like 'with errors' do
        let(:attrs) { { email: nil } }
        let(:errors) { ['Email can\'t be blank', 'Email is invalid'] }
      end

      it_behaves_like 'with errors' do
        let(:attrs) { { password: nil } }
        let(:errors) { ['Password can\'t be blank', 'Password is too short (minimum is 6 characters)'] }
      end
    end
  end
end
