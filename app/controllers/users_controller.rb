# Users controller handles logic associated with managing users:
#  new/create, edit/update, destroy, view (one), and index (all)
class UsersController < ApplicationController

  before_filter :logged_in?, :except => [:new]

  before_filter :find_user, :only => [:destroy, :edit, :show, :update]

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

  def edit
    respond_to do | format |
      format.html # edit.html.erb
      format.xml { render :xml => @user }
    end
  end

  def index
    @users = User.order(sort_column + " " + sort_direction).search(params[:search]).paginate(:per_page => 4, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @users }
    end
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to(@user, :notice => 'Updated user')
    else
      render :action => "edit"
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user }
    end
  end

  protected
    def find_user
      @user = User.find(params[:id])
    end

  private

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "lastname"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
