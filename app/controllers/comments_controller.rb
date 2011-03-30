# The Comments Controller handles blog post comments
class CommentsController < ApplicationController

  before_filter :logged_in?, :only => :destroy
  before_filter :authorized, :only => [:edit, :update]

  def create
    if comment.save
      user_session.add_comment(comment)

      flash[:notice] = "Successfully created comment."
      redirect_to post_path(post)
    else
      render :action => 'new'
    end
  end

  # destroy before_filters: logged_in?
  def destroy
    comment.destroy
    redirect_to post_path(post)
  end

  # edit before_filters: authorized
  def edit
  end

  # show before_filters: authorized
  def show
  end

  # update before_filters: authorized
  def update
    if comment.update_attributes(params[:comment])
      flash[:notice] = "Successfully updated comment."
      redirect_to post_path(post)
    else
      render :action => 'edit'
    end
  end

  private

  def authorized
    unless user_session.can_edit_comment?(Comment.find(params[:id]))
      redirect_to root_url
    end
  end

  def post
    @post ||= params[:post_id] ? Post.find(params[:post_id]) : Post.new(params[:post])
  end
  helper_method :post

  def comment
    @comment ||= params[:id] ? post.comments.find(params[:id]) : post.comments.create(params[:comment])
  end
  helper_method :comment

end

