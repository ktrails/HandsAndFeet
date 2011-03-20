class CommentsController < ApplicationController

  before_filter :logged_in?, :only => :destroy
  before_filter :authorized, :only => [:edit, :update]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    session[:comment_ids] ||= []
    session[:comment_ids] << @comment.id
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def show
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Successfully updated comment."
      redirect_to posts_path
    else
      render :action => 'edit'
    end
  end

  private

  def authorized
    unless session[:comment_ids] && session[:comment_ids].include?(params[:id].to_i)
      redirect_to root_url
    end
  end

end

