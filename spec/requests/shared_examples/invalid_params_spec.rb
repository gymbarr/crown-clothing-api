require 'rails_helper'

shared_examples 'with errors' do
  it 'has errors' do
    expect(json['errors']).to eq(errors)
  end

  it 'returns unprocessable_entity status' do
    expect(response).to have_http_status(:unprocessable_entity)
  end
end
