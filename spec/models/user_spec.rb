# frozen_string_literal: true

require 'rails_helper'
require 'models/shared_examples/validation_spec'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'when valid attributes' do
      subject(:user) { build(:user) }

      include_examples 'valid object'
    end

    context 'when invalid attributes' do
      subject(:user) { build(:user, **attrs) }

      let(:attrs) { { username: nil, email: nil, password: nil, roles: [] } }

      include_examples 'invalid object'

      it_behaves_like 'with errors' do
        let(:attr) { :username }
        let(:errors) { ['can\'t be blank', 'is invalid'] }
      end

      it_behaves_like 'with errors' do
        let(:attr) { :email }
        let(:errors) { ['can\'t be blank', 'is invalid'] }
      end

      it_behaves_like 'with errors' do
        let(:attr) { :password }
        let(:errors) { ['can\'t be blank', 'is too short (minimum is 6 characters)'] }
      end
    end

    context 'when attributes are not unique' do
      subject(:user) { build(:user, **attrs) }

      let(:another_user) { create(:user) }
      let(:attrs) { { username: another_user.username, email: another_user.email } }

      it_behaves_like 'with errors' do
        let(:attr) { :username }
        let(:errors) { ['has already been taken'] }
      end

      it_behaves_like 'with errors' do
        let(:attr) { :email }
        let(:errors) { ['has already been taken'] }
      end
    end

    context 'when invalid attributes on update' do
      subject(:user) { create(:user) }

      it_behaves_like 'with errors on update' do
        let(:attr) { :roles }
        let(:errors) { ['can\'t be blank'] }
      end
    end
  end

  describe 'associations' do
    subject(:user) { create(:user, roles: [role]) }

    let(:role) { create(:role) }

    it 'has roles' do
      expect(user.roles).to contain_exactly(role)
    end
  end
end
