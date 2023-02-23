# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Authorization::JsonWebTokenEncoder, type: :service do
  describe '.call' do
    subject(:encoded) { described_class.call(user_id: user.id) }

    let(:user) { create(:user) }

    it 'returns a JWT token' do
      expect(encoded).to be_a(String)
      segments = encoded.split('.')
      expect(segments.size).to eq(3)
    end
  end
end
