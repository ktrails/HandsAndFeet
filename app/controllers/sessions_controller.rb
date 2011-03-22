# Session controller handles association of user id with login session
class SessionsController < ApplicationController

  before_filter :logged_in?, :except => [:new, :create]

  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      user_session.current_user = user.id
      redirect_to users_path, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  # destroy has before_filter: logged_in?
  def destroy
    user_session.current_user = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
