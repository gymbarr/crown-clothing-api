require 'rails_helper'

RSpec.describe ActiveModelSerializers::UserSerializer, type: :serializer do
  describe '.serializable_hash' do
    subject(:user_serializer) { described_class.new(user).serializable_hash }

    let(:user) { create(:user) }

    it 'returns correct keys and values' do
      expect(user_serializer).to include(
        id: user.id,
        username: user.username,
        email: user.email,
        roles_name: user.roles_name
      )
    end
  end
end
