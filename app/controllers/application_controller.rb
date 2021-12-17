class ApplicationController < ActionController::API
  #include ::ActionController::Serialization
  include Pundit

  before_action :authenticate_user!

  private
    def authenticate_user!
      super if user_signed_in?
    end
end
