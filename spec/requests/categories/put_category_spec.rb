require 'rails_helper'
require 'requests/shared_examples/invalid_params_spec'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Categories', type: :request do
  describe 'PUT /api/categories/:category_title' do
    subject(:put_category_request) do
      put "/api/categories/#{category.title}",
          params: new_params,
          headers:
    end

    let(:category) { create :category }

    before do
      put_category_request
    end

    context 'when authorized user' do
      let(:user) { create :user, :with_admin_role }
      let(:headers) { user_auth_header(user) }

      context 'with valid parameters' do
        let(:new_params) { attributes_for :category }

        it 'changes the category title' do
          expect(category.reload.title).to eq(new_params[:title])
        end

        it 'returns ok status' do
          expect(response).to have_http_status(:ok)
        end
      end

      context 'with invalid parameters' do
        let(:new_params) { attributes_for :category, **attrs }

        it_behaves_like 'with errors' do
          let(:attrs) { { title: nil } }
          let(:errors) { ['Title can\'t be blank', 'Title is too short (minimum is 3 characters)'] }
          let(:status) { :unprocessable_entity }
        end
      end
    end

    context 'when unauthorized user' do
      let(:new_params) { attributes_for :category }

      include_examples 'not authorized'
    end
  end
end
