require 'rails_helper'

RSpec.describe ProductPolicy do
  subject { described_class.new(user, product) }

  let(:product) { create(:product) }

  context 'when the user is an administrator' do
    let(:user) { create(:user, :with_admin_role) }

    it { is_expected.to permit_actions(%i[index show create update destroy]) }
  end

  context 'when the user is a basic user' do
    let(:user) { create(:user) }

    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[create update destroy]) }
  end
end
