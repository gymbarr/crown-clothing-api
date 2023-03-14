# frozen_string_literal: true

module Authorizable
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization

    after_action :verify_authorized

    rescue_from Pundit::NotAuthorizedError, with: :not_authorized

    private

    def not_authorized
      render json: { errors: 'You are not authorized to perform this action' }, status: :unauthorized
    end

    def pundit_user
      @current_user
    end
  end
end
