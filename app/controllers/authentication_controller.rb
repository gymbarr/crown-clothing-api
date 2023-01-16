class AuthenticationController < ApplicationController
  skip_after_action :verify_authorized

  # POST /auth/login
  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      token = Authorization::JsonWebTokenEncoder.call(user_id: @user.id)
      response.headers['token'] = token

      render json: @user, status: :ok
    else
      render json: { errors: ['Invalid email or password'] }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
