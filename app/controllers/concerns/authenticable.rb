# frozen_string_literal: true

module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request

    def authenticate_request
      header = request.headers['Authorization']

      return unless header

      begin
        decoded = Authentications::JsonWebTokenDecoder.call(header)
        @current_user = User.find(decoded[:user_id])

        # refresh token
        token = Authentications::JsonWebTokenEncoder.call(user_id: @current_user.id)
        response.headers['token'] = token
      rescue JWT::ExpiredSignature, JWT::DecodeError, ActiveRecord::RecordNotFound => e
        not_authenticated(e)
      end
    end

    private

    def not_authenticated(exception)
      render json: { errors: exception.message }, status: :unauthorized
    end
  end
end
