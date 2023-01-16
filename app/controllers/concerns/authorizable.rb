module Authorizable
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization

    before_action :authorize_request
    after_action :verify_authorized

    def authorize_request
      header = request.headers['Authorization']

      return unless header

      begin
        @decoded = Authorization::JsonWebTokenDecoder.call(header)
        @current_user = User.find(@decoded[:user_id])

        # refresh token
        token = Authorization::JsonWebTokenEncoder.call(user_id: @current_user.id)
        response.headers['token'] = token
      rescue JWT::ExpiredSignature, JWT::DecodeError, ActiveRecord::RecordNotFound => e
        user_not_authorized(e)
      end
    end

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized(exception)
      render json: { errors: exception.message }, status: :unauthorized
    end

    def pundit_user
      @current_user
    end
  end
end
