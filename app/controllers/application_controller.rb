class ApplicationController < ActionController::API
  include ErrorHandleable
  include Authorizable
end
