# frozen_string_literal: true

module ErrorHandleable
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    private

    def record_not_found
      render json: { errors: 'Resource not found' }, status: :not_found
    end
  end
end
