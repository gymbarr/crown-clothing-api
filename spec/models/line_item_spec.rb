# frozen_string_literal: true

require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe LineItem, type: :model do
  describe 'validations' do
    context 'when valid attributes' do
      subject(:line_item) { build(:line_item) }

      include_examples 'valid object'
    end

    context 'when invalid attributes' do
      subject(:line_item) { build(:line_item, **attrs) }

      let(:attrs) { { order: nil, product: nil, quantity: nil } }

      include_examples 'invalid object'

      it_behaves_like 'with errors' do
        let(:attr) { :order }
        let(:errors) { ['must exist'] }
      end

      it_behaves_like 'with errors' do
        let(:attr) { :product }
        let(:errors) { ['must exist'] }
      end

      it_behaves_like 'with errors' do
        let(:attr) { :quantity }
        let(:errors) { ['can\'t be blank', 'is not a number'] }
      end
    end
  end

  describe 'associations' do
    subject(:line_item) { create(:line_item, order:, product:) }

    let(:order) { create(:order) }
    let(:product) { create(:product) }

    it 'has an order' do
      expect(line_item.order).to eq(order)
    end

    it 'has a product' do
      expect(line_item.product).to eq(product)
    end
  end
end
