class ApplicationController < ActionController::API
  include ErrorHandling
  include Authorization
end
