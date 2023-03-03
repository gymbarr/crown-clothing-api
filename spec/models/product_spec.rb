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
    subject(:product) { create(:product, category:, variants:) }

    let(:category) { create(:category) }
    let(:variants) { create_list(:variant, 3) }

    it 'has category' do
      expect(product.category).to eq(category)
    end

    it 'has variants' do
      expect(product.variants).to eq(variants)
    end
  end
end
