module Authorizable
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization

    before_action :authorize_request

    def authorize_request
      header = request.headers['Authorization']
      header = header.split.last if header
      begin
        @decoded = Authorization::JsonWebTokenDecoder.call(header)
        @current_user = User.find(@decoded[:user_id])

        # token refreshing
        token = Authorization::JsonWebTokenEncoder.call(user_id: @current_user.id)
        response.headers['token'] = token
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
        user_not_authorized(e)
      end
    end

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized(exception)
      render json: { errors: exception.message }, status: :unauthorized
    end
  end
end
