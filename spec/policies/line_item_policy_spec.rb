# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineItemPolicy do
  let(:user) { create(:user) }
  let(:line_item) { create(:line_item, order:) }

  context 'when the user is authenticated' do
    subject { described_class.new(user, line_item) }

    context 'when the line item belongs to the same user' do
      let(:order) { create(:order, user:) }

      it { is_expected.to permit_actions(%i[increment_quantity decrement_quantity destroy]) }
    end

    context 'when the line_item belongs to other user' do
      let(:another_user) { create(:user) }
      let(:order) { create(:order, user: another_user) }

      it { is_expected.to forbid_actions(%i[increment_quantity decrement_quantity destroy]) }
    end
  end

  context 'when the user is not authenticated' do
    subject { described_class.new(nil, order) }

    let(:order) { create(:order) }

    it { is_expected.to forbid_actions(%i[increment_quantity decrement_quantity destroy]) }
  end
end
