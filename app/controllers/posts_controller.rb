# The Posts controller manages the posts, consisting of posts and comments
class PostsController < ApplicationController

  before_filter :logged_in?, :except => [:index, :show]
  before_filter :find_post, :only => [:destroy, :edit, :show, :update]
  before_filter :format_response, :only => [:edit, :show]
  
  helper_method :sort_column, :sort_direction

  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @post }
    end
  end

  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post,
                      :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post,
                      :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  # destroy uses before filter find_post
  def destroy
    @post.destroy if @post
 
    respond_to do |format|
      format.html { redirect_to posts_url, :notice => "Deleted post!" }
      format.xml  { head :ok }
    end
  end

  # edit uses before_filter(s): find_post, format_response
  def edit
  end

  def index
    @posts = Post.order(sort_column + " " + sort_direction).search(params[:search]).paginate(:per_page => 8, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @posts }
    end
  end

  # show uses before_filter(s): find_post, format_response
  def show
  end

  # update uses before filter find_post
  def update
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post,
                      :notice => 'Updated post') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors,
                      :status => :unprocessable_entity }
    
      end
    end
  end

  protected

    def find_post
      @post = Post.find(params[:id])
    end

    def format_response
      respond_to do |format|
        format.html # use corresponding .html.erb file
        format.xml { render :xml => @post }
      end
    end

  private

  def sort_column
    Post.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
