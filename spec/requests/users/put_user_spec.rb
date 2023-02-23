# frozen_string_literal: true

require 'rails_helper'
require 'requests/shared_examples/invalid_params_spec'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Users', type: :request do
  describe 'PUT /api/users/:username' do
    subject(:put_user_request) do
      put "/api/users/#{user.username}",
          params: new_params,
          headers:
    end

    let(:user) { create(:user) }

    before do
      put_user_request
    end

    context 'when authorized user' do
      let(:headers) { user_auth_header(user) }

      context 'with valid parameters' do
        let(:new_params) { attributes_for(:user) }

        it 'changes the user username' do
          expect(user.reload.username).to eq(new_params[:username])
        end

        it 'changes the user email' do
          expect(user.reload.email).to eq(new_params[:email])
        end

        it 'changes the user password' do
          expect(user.reload.authenticate(new_params[:password])).to eq(user)
        end

        it 'returns ok status' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'with invalid parameters' do
        let(:new_params) { attributes_for(:user, **attrs) }

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
          let(:errors) { ['Password can\'t be blank'] }
          let(:status) { :unprocessable_entity }
        end
      end
    end

    context 'when unauthorized user' do
      let(:new_params) { attributes_for(:user) }

      include_examples 'not authorized'
    end
  end
end
