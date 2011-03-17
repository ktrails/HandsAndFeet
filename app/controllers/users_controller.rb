# Users controller handles logic associated with managing users:
#  new/create, edit/update, destroy, view (one), and index (all)
class UsersController < ApplicationController

  # before_filters: order matters!
  before_filter :logged_in?, :except => [:new]
  before_filter :find_user, :only => [:destroy, :edit, :show, :update]
  before_filter :format_response, :only => [:edit, :show]

  helper_method :sort_column, :sort_direction

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def destroy
    @user.destroy if @user
    redirect_to root_url, :notice => "Deleted user!"
  end

  # edit before_filters: logged_in?, find_user, format_response
  def edit
  end

  def index
    @users = User.order(sort_column + " " + sort_direction).search(params[:search]).paginate(:per_page => 4, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @users }
    end
  end

  # show before_filters: logged_in?, find_user, format_response
  def show
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to(@user, :notice => 'Updated user')
    else
      render :action => "edit"
    end
  end

  protected
    def find_user
      @user = User.find(params[:id])
    end
    
    def format_response
      respond_to do |format|
        format.html # use corresponding .html.erb file
        format.xml { render :xml => @user }
      end
    end

  private

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "lastname"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
