module Authorizable
  extend ActiveSupport::Concern

  included do
    before_action :authorize_request

    def authorize_request
      header = request.headers['Authorization']
      header = header.split.last if header
      begin
        @decoded = Authorization::JsonWebTokenDecoder.call(header)
        @current_user = User.find(@decoded[:user_id])

        token = Authorization::JsonWebTokenEncoder.call(user_id: @current_user.id)
        response.headers['token'] = token
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end
  end
end
