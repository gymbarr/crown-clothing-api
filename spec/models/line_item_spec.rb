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

      let(:variant) { create(:variant, quantity: 0) }
      let(:attrs) { { order: nil, variant:, quantity: 1 } }

      include_examples 'invalid object'

      it_behaves_like 'with errors' do
        let(:attr) { :order }
        let(:errors) { ['must exist'] }
      end

      it_behaves_like 'with errors' do
        let(:attr) { :quantity }
        let(:errors) { ["#{variant.title} is out of stock, just #{variant.quantity} left"] }
      end
    end
  end

  describe 'associations' do
    subject(:line_item) { create(:line_item, order:, variant:) }

    let(:order) { create(:order) }
    let(:variant) { create(:variant) }

    it 'has an order' do
      expect(line_item.order).to eq(order)
    end

    it 'has a product' do
      expect(line_item.variant).to eq(variant)
    end
  end

  describe 'delegations' do
    subject(:line_item) { create(:line_item, order:, variant:) }

    let(:user) { create(:user) }
    let(:order) { create(:order, user:) }
    let(:variant) { create(:variant) }

    it 'delegate a title to the variant' do
      expect(line_item.title).to eq(variant.title)
    end

    it 'delegate a color to the variant' do
      expect(line_item.color).to eq(variant.color)
    end

    it 'delegate a size to the variant' do
      expect(line_item.size).to eq(variant.size)
    end

    it 'delegate an image to the variant' do
      expect(line_item.image).to eq(variant.image)
    end

    it 'delegate the user to the order' do
      expect(line_item.user).to eq(user)
    end
  end

  describe '#set_order_total!' do
    subject(:update_line_item) { line_item.update(quantity: new_quantity) }

    let(:order) { create(:order, line_items: [line_item]) }
    let(:line_item) { create(:line_item, quantity: old_quantity) }
    let(:old_total) { line_item.variant.price * old_quantity }
    let(:new_total) { line_item.variant.price * new_quantity }
    let(:old_quantity) { 1 }
    let(:new_quantity) { 2 }

    it 'updates total price of the order' do
      expect { update_line_item }.to change(order, :total).from(old_total).to(new_total)
    end
  end
end
