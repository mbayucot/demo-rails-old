class ApplicationController < ActionController::API
  include ::ActionController::Serialization
  include Pundit
end
