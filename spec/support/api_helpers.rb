# frozen_string_literal: true

module ApiHelpers
  def json
    JSON.parse(response.body)
  end

  def user_auth_header(user)
    { 'Authorization' => Authorizations::JsonWebTokenEncoder.call(user_id: user.id) }
  end
end
