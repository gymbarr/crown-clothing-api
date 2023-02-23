# frozen_string_literal: true

require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe Category, type: :model do
  describe 'validations' do
    context 'when valid attributes' do
      subject(:category) { build(:category) }

      include_examples 'valid object'
    end

    context 'when invalid attributes' do
      subject(:category) { build(:category, **attrs) }

      let(:attrs) { { title: nil } }

      include_examples 'invalid object'

      it_behaves_like 'with errors' do
        let(:attr) { :title }
        let(:errors) { ['can\'t be blank', 'is too short (minimum is 3 characters)'] }
      end
    end

    context 'when attributes are not unique' do
      subject(:category) { build(:category, **attrs) }

      let(:another_category) { create(:category) }
      let(:attrs) { { title: another_category.title } }

      it_behaves_like 'with errors' do
        let(:attr) { :title }
        let(:errors) { ['has already been taken'] }
      end
    end
  end

  describe 'associations' do
    subject(:category) { create(:category) }

    let(:products) { create_list(:product, 3, category:) }

    it 'has products' do
      expect(category.products).to match_array(products)
    end
  end
end
