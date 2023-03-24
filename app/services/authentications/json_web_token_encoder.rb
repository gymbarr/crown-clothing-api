# frozen_string_literal: true

module Authentications
  class JsonWebTokenEncoder < ApplicationService
    SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

    def initialize(payload, exp = 60.minutes.from_now)
      super()
      @payload = payload
      @exp = exp
    end

    def call
      @payload[:exp] = @exp.to_i
      JWT.encode(@payload, SECRET_KEY)
    end
  end
end
