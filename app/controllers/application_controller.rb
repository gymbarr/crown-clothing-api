class ApplicationController < ActionController::API
  include Pagy::Backend
  include ErrorHandleable
  include Authorizable
end
