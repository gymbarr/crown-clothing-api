# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActiveStorage::SetCurrent
  include Pagy::Backend
  include ErrorHandleable
  include Authenticable
  include Authorizable
end
