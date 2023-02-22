require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class.new(user, user_record) }

  let(:user_record) { create(:user) }

  context 'when the user is an administrator' do
    let(:user) { create(:user, :with_admin_role) }

    it { is_expected.to permit_actions(%i[index show create update destroy me]) }
  end

  context 'when the user is a basic user' do
    context 'when the user and the record user are the same' do
      let(:user) { user_record }

      it { is_expected.to permit_actions(%i[create show update destroy me]) }
      it { is_expected.to forbid_actions(%i[index]) }
    end

    context 'when the user and the record user are different' do
      let(:user) { create(:user) }

      it { is_expected.to permit_actions(%i[create me]) }
      it { is_expected.to forbid_actions(%i[index show update destroy]) }
    end
  end
end
