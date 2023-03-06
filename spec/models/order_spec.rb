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
      subject(:order) { build(:order, line_items:, **attrs) }

      let(:attrs) { { user: nil, total: nil, status: nil } }
      let(:variant) { create(:variant, quantity: 0) }
      let(:line_items) { build_list(:line_item, 1, variant:) }

      include_examples 'invalid object'

      it_behaves_like 'with errors' do
        let(:attr) { :user }
        let(:errors) { ['must exist'] }
      end

      it_behaves_like 'with errors' do
        let(:attr) { :status }
        let(:errors) { ['can\'t be blank'] }
      end

      it_behaves_like 'with errors' do
        let(:attr) { :line_items }
        let(:errors) { ["#{variant.title} is out of stock, just #{variant.quantity} left"] }
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

  describe '#build_line_items' do
    subject(:build_line_items) { order.build_line_items(items) }

    let(:order) { create(:order) }
    let(:variants) { create_list(:variant, 2) }
    let(:items) { variants.map { |variant| { variant_id: variant.id, quantity: rand(1..5) } } }

    it 'builds line items for order' do
      build_line_items
      expect(order.line_items.size).to eq(items.count)
    end
  end

  describe '#set_total!' do
    subject(:order) { build(:order, :with_line_items, line_items_count: 2) }

    let(:line_items_price) do
      order.line_items.inject(0) do |total, item|
        total + (item.price * item.quantity)
      end
    end

    it 'sets the order total price' do
      expect { order.save }.to change(order, :total).from(0).to(line_items_price)
    end
  end
end
