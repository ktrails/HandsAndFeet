# The Comments Controller handles blog post comments
class CommentsController < ApplicationController

  before_filter :logged_in?, :only => :destroy
  before_filter :authorized, :only => [:edit, :update]
  before_filter :find_comment, :only => [:destroy, :edit, :show, :update]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    if @comment.save
      user_session.add_comment(@comment)

      flash[:notice] = "Successfully created comment."
      redirect_to post_path(@post)
    else
      render :action => 'new'
    end
  end

  # destroy before_filters: logged_in?, find_comment
  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  # edit before_filters: authorized, find_comment
  def edit
  end

  # show before_filters: authorized, find_comment
  def show
  end

  # update before_filters: authorized, find_comment
  def update
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Successfully updated comment."
      redirect_to post_path(@post)
    else
      render :action => 'edit'
    end
  end

  protected

  def find_comment
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  private

  def authorized
    unless user_session.can_edit_comment?(Comment.find(params[:id]))
      redirect_to root_url
    end
  end

end

