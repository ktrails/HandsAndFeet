# The User Session will manage user data associated with a session
class UserSession

  def initialize(session)
    @session = session
    @session[:comment_ids] ||= []
    @current_user = nil
  end

  def add_comment(comment)
    @session[:comment_ids] << comment.id
  end

  def can_edit_comment?(comment)
    @session[:comment_ids].include?(comment.id) && comment.created_at > 15.minutes.ago
  end

  def current_user
    @current_user ||= User.find(@session[:user_id]) if @session[:user_id]
  end

  def current_user=(user_id)
    @session[:user_id] = user_id
  end
end