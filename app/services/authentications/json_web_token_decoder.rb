# frozen_string_literal: true

module Authentications
  class JsonWebTokenDecoder < ApplicationService
    SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

    def initialize(token)
      super()
      @token = token
    end

    def call
      decoded = JWT.decode(@token, SECRET_KEY)[0]
      ActiveSupport::HashWithIndifferentAccess.new decoded
    end
  end
end
