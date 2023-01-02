require 'rails_helper'
require 'requests/shared_examples/invalid_params_spec'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Categories', type: :request do
  describe 'POST /api/categories' do
    subject(:post_categories_request) do
      post '/api/categories', headers:, params:
    end

    before do
      post_categories_request
    end

    context 'when authorized user' do
      let(:user) { create :user, :with_admin_role }
      let(:headers) { user_auth_header(user) }

      context 'with valid parameters' do
        let(:params) { attributes_for :category }

        it 'returns a title' do
          expect(json['title']).to eq(params[:title])
        end

        it 'returns created status' do
          expect(response).to have_http_status(:created)
        end
      end

      context 'with invalid parameters' do
        let(:params) { attributes_for :category, **attrs }

        it_behaves_like 'with errors' do
          let(:attrs) { { title: nil } }
          let(:errors) { ['Title can\'t be blank', 'Title is too short (minimum is 3 characters)'] }
          let(:status) { :unprocessable_entity }
        end
      end
    end

    context 'when unauthorized user' do
      let(:params) { nil }

      include_examples 'not authorized'
    end
  end
end
