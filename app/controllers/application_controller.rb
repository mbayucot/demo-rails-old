class ApplicationController < ActionController::API
  #include ::ActionController::Serialization
  include Pundit
  include ExceptionHandler
end
