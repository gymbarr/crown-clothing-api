module ApiHelpers
  def json
    JSON.parse(response.body)
  end

  def user_token(user)
    Authorization::JsonWebTokenEncoder.call(user_id: user.id)
  end
end
