module ApiHelpers
  def json
    JSON.parse(response.body)
  end

  def user_token(user)
    JsonWebToken.encode(user_id: user.id)
  end
end
