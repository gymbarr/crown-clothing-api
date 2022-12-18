require 'rails_helper'

shared_examples 'not authorized' do
  it 'returns error' do
    expect(json['errors']).to eq('Nil JSON web token')
  end

  it 'returns unauthorized status' do
    expect(response).to have_http_status(:unauthorized)
  end
end
