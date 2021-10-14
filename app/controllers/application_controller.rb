class ApplicationController < ActionController::API
  #include ::ActionController::Serialization
  include Pundit
  include ExceptionHandler

  #before_action :authenticate_user!
end
