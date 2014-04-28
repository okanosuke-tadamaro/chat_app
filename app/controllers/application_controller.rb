class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :signed_in?, :current_user

  private

  def signed_in?
    true if session[:oauth_token]
  end


end
