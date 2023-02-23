# frozen_string_literal: true

require 'rails_helper'

shared_examples 'not authorized' do
  it 'returns error' do
    expect(json['errors']).to eq('You are not authorized to perform this action')
  end

  it 'returns unauthorized status' do
    expect(response).to have_http_status(:unauthorized)
  end
end
