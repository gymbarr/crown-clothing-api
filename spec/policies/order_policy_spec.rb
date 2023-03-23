# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderPolicy do
  context 'when the user is authenticated' do
    subject { described_class.new(user, order) }

    let(:user) { create(:user) }

    context 'when the order belongs to the same user' do
      let(:order) { create(:order, user:) }

      it { is_expected.to permit_actions(%i[index show create destroy]) }
    end

    context 'when the order belongs to other user' do
      let(:another_user) { create(:user) }
      let(:order) { create(:order, user: another_user) }

      it { is_expected.to permit_actions(%i[index create]) }
      it { is_expected.to forbid_actions(%i[show destroy]) }
    end
  end

  context 'when the user is not authenticated' do
    subject { described_class.new(nil, order) }

    let(:order) { create(:order) }

    it { is_expected.to forbid_actions(%i[index show create destroy]) }
  end
end
