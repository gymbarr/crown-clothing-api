# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Authentications::JsonWebTokenDecoder, type: :service do
  describe '.call' do
    subject(:decoded) { described_class.call(token) }

    let(:user) { create(:user) }
    let(:token) { Authentications::JsonWebTokenEncoder.call(user_id: user.id) }

    it 'returns a hash' do
      expect(decoded).to be_a(Hash)
    end

    it 'contains the user id' do
      expect(decoded[:user_id]).to eq(user.id)
    end

    it 'contains the expiration time' do
      expect(decoded[:exp]).to be_a(Integer)
    end
  end
end
