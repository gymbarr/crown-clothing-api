class ApplicationController < ActionController::API
  include ActiveStorage::SetCurrent
  include Pagy::Backend
  include ErrorHandleable
  include Authorizable
end
