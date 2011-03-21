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
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def show
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Successfully updated comment."
      redirect_to post_path(@post)
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

