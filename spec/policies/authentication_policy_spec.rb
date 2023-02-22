require 'rails_helper'

RSpec.describe AuthenticationPolicy do
  subject { described_class.new(user, nil) }

  let(:user) { create(:user) }

  it { is_expected.to permit_actions(%i[login]) }
end
