# frozen_string_literal: true

require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe Product, type: :model do
  describe 'validations' do
    context 'when valid attributes' do
      subject(:product) { build(:product) }

      include_examples 'valid object'
    end

    context 'when invalid attributes' do
      subject(:product) { build(:product, **attrs) }

      let(:attrs) { { title: nil } }

      include_examples 'invalid object'

      it_behaves_like 'with errors' do
        let(:attr) { :title }
        let(:errors) { ['can\'t be blank', 'is too short (minimum is 3 characters)'] }
      end
    end
  end

  describe 'associations' do
    subject(:product) { create(:product, category:, line_items:) }

    let(:category) { create(:category) }
    let(:line_items) { create_list(:line_item, 3, order:) }
    let(:order) { create(:order) }

    it 'has category' do
      expect(product.category).to eq(category)
    end

    it 'has line items' do
      expect(product.line_items).to match_array(line_items)
    end

    it 'has orders' do
      expect(product.orders).to contain_exactly(order)
    end
  end
end
