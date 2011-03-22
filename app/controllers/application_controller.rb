# Main application controller class
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?

  protected

  def current_user
    @user_session.current_user
  end

  def logged_in?
    unless user_session.current_user
      flash[:notice] = "You need to log in first."
        redirect_to root_url
        return false
    else
        return true
    end
  end

  private

  def user_session
    @user_session ||= UserSession.new(session)
  end
  helper_method :user_session

end
