# frozen_string_literal: true

require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe Order, type: :model do
  describe 'validations' do
    context 'when valid attributes' do
      subject(:order) { build(:order) }

      include_examples 'valid object'
    end

    context 'when invalid attributes' do
      subject(:order) { build(:order, **attrs) }

      let(:attrs) { { user: nil, total: nil, status: nil } }

      include_examples 'invalid object'

      it_behaves_like 'with errors' do
        let(:attr) { :user }
        let(:errors) { ['must exist'] }
      end

      it_behaves_like 'with errors' do
        let(:attr) { :total }
        let(:errors) { ['can\'t be blank', 'is not a number'] }
      end

      it_behaves_like 'with errors' do
        let(:attr) { :status }
        let(:errors) { ['can\'t be blank'] }
      end
    end
  end

  describe 'associations' do
    subject(:order) { create(:order, user:, line_items:) }

    let(:user) { create(:user) }
    let(:line_items) { create_list(:line_item, 3) }

    it 'has a user' do
      expect(order.user).to eq(user)
    end

    it 'has line items' do
      expect(order.line_items).to match_array(line_items)
    end
  end
end
