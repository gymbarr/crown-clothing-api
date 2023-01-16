module Authorization
  class JsonWebTokenEncoder < ApplicationService
    SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

    def initialize(payload, exp = 30.seconds.from_now)
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
