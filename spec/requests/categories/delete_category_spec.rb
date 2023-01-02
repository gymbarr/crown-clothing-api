require 'rails_helper'
require 'requests/shared_examples/not_authorized_spec'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'Categories', type: :request do
  describe 'DELETE /api/categories/:title' do
    subject(:delete_category_request) do
      delete "/api/categories/#{category.title}", headers:
    end

    let(:category) { create :category }

    before do
      delete_category_request
    end

    context 'when authorized user' do
      let(:user) { create :user, :with_admin_role }
      let(:headers) { user_auth_header(user) }

      it 'decrements the count of categories by 1' do
        expect(Category.count).to eq(0)
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
