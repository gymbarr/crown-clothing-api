# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChargePolicy do
  subject { described_class.new(user, nil) }

  context 'when authorized user' do
    let(:user) { create(:user) }

    it { is_expected.to permit_actions(%i[create]) }
  end

  context 'when unauthorized user' do
    let(:user) { nil }

    it { is_expected.to forbid_actions(%i[create]) }
  end
end
