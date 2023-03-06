# frozen_string_literal: true

require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe Variant, type: :model do
  describe 'validations' do
    context 'when valid attributes' do
      subject(:variant) { build(:variant) }

      include_examples 'valid object'
    end

    context 'when invalid attributes' do
      subject(:variant) { build(:variant, **attrs) }

      let(:attrs) { { color: nil, size: nil, product: nil, quantity: nil } }

      include_examples 'invalid object'

      it_behaves_like 'with errors' do
        let(:attr) { :color }
        let(:errors) { ['can\'t be blank'] }
      end

      it_behaves_like 'with errors' do
        let(:attr) { :size }
        let(:errors) { ['can\'t be blank'] }
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

    context 'when attributes are not unique' do
      subject(:variant) { build(:variant, **attrs) }

      let(:another_variant) { create(:variant) }
      let(:attrs) do
        { color: another_variant.color, size: another_variant.size, product_id: another_variant.product_id }
      end

      it_behaves_like 'with errors' do
        let(:attr) { :size }
        let(:errors) { ['such variant is already exist'] }
      end
    end
  end

  describe 'associations' do
    subject(:variant) { create(:variant, product:, line_items:) }

    let(:product) { create(:product) }
    let(:line_items) { create_list(:line_item, 3, order:) }
    let(:order) { create(:order) }

    it 'has a product' do
      expect(variant.product).to eq(product)
    end

    it 'has line items' do
      expect(variant.line_items).to match_array(line_items)
    end

    it 'has orders' do
      expect(variant.orders).to contain_exactly(order)
    end
  end

  describe 'delegations' do
    subject(:variant) { create(:variant, product:) }

    let(:product) { create(:product) }

    it 'delegate a title to the product' do
      expect(variant.title).to eq(product.title)
    end

    it 'delegate a price to the product' do
      expect(variant.price).to eq(product.price)
    end

    it 'delegate an image to the product' do
      expect(variant.image).to eq(product.image)
    end

    it 'delegate a category id to the product' do
      expect(variant.category_id).to eq(product.category_id)
    end
  end
end
