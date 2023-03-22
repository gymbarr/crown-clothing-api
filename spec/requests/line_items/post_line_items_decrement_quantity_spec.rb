# frozen_string_literal: true

require 'rails_helper'
require 'requests/shared_examples/invalid_params_spec'
require 'requests/shared_examples/not_authorized_spec'

RSpec.describe 'LineItems', type: :request do
  describe 'POST /api/line_items/:id/decrement_quantity' do
    subject(:post_line_items_decrement_quantity_request) do
      post "/api/line_items/#{line_item.id}/decrement_quantity", headers:
    end

    let(:user) { create(:user) }
    let(:order) { create(:order, user:) }
    let(:variant) { create(:variant, quantity: 5) }
    let(:line_item) { create(:line_item, order:, variant:, quantity: old_quantity) }
    let(:old_quantity) { 3 }

    before do
      post_line_items_decrement_quantity_request
    end

    context 'when authorized user' do
      let(:headers) { user_auth_header(user) }

      it 'decrements line item quantity' do
        expect(line_item.reload.quantity).to eq(old_quantity - 1)
      end

      context 'with valid parameters' do
        it 'returns the decremented quantity' do
          expect(json['quantity']).to eq(old_quantity - 1)
        end

        # it 'returns the product price' do
        #   expect(json['price']).to eq(params[:price])
        # end

        # it 'returns the category title' do
        #   expect(json['category']).to eq(category.title)
        # end

        it 'returns created status' do
          expect(response).to have_http_status(:created)
        end
      end
    end

    #   context 'with invalid parameters' do
    #     let(:params) { attributes_for(:product, **attrs) }

    #     it_behaves_like 'with errors' do
    #       let(:attrs) { { title: nil, category_id: category.id } }
    #       let(:errors) { ['Title can\'t be blank', 'Title is too short (minimum is 3 characters)'] }
    #       let(:status) { :unprocessable_entity }
    #     end

    #     it_behaves_like 'with errors' do
    #       let(:attrs) { { category_id: nil } }
    #       let(:errors) { ['Category must exist'] }
    #       let(:status) { :unprocessable_entity }
    #     end
    #   end
    # end

    # context 'when unauthorized user' do
    #   let(:params) { nil }

    #   include_examples 'not authorized'
    # end
  end
end
