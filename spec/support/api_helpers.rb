module ApiHelpers
  def json
    JSON.parse(response.body)
  end

  def user_auth_header(user)
    { 'Authorization' => Authorization::JsonWebTokenEncoder.call(user_id: user.id) }
  end
end
