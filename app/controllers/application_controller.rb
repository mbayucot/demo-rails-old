class ApplicationController < ActionController::API
  #include ::ActionController::Serialization
  include Pundit

  before_action :authenticate_user!
end
