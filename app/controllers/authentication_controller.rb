class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, raise: false

  # POST /auth/login
  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      token = Authorization::JsonWebTokenEncoder.call(user_id: @user.id)
      time = Time.zone.now + 24.hours.to_i
      render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'),
                     username: @user.username }, status: :ok
    else
      render json: { errors: ['Unauthorized'] }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
