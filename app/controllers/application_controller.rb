# Main application controller class
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?

  protected

  def logged_in?
    unless current_user
      flash[:notice] = "You need to log in first."
        redirect_to root_url
        return false
    else
        return true
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_session
    @user_session ||= UserSession.new(session)
  end
  helper_method :user_session
end
