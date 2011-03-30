# Users controller handles logic associated with managing users:
#  new/create, edit/update, destroy, view (one), and index (all)
class UsersController < ApplicationController

  # before_filters: order matters!
  before_filter :logged_in?, :except => [:new]
  before_filter :format_response, :only => [:edit, :show]

  helper_method :sort_column, :sort_direction

  def new
  end

  def create
    if user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def destroy
    user.destroy if user
    respond_to do |format|
      format.html { redirect_to users_url, :notice => "Deleted user!" }
      format.xml  { head :ok }
    end
  end

  # edit before_filters: logged_in?, find_user, format_response
  def edit
  end

  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => users }
    end
  end

  # show before_filters: logged_in?, find_user, format_response
  def show
  end

  def update
    respond_to do |format|
      if user.update_attributes(params[:user])
        format.html { redirect_to(user,
                      :notice => 'Updated user') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => user.errors,
                      :status => :unprocessable_entity }

      end
    end
  end

  protected

    def format_response
      respond_to do |format|
        format.html # use corresponding .html.erb file
        format.xml { render :xml => user }
      end
    end

  private

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "lastname"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def users
    @users ||= User.order(sort_column + " " + sort_direction).search(params[:search]).paginate(:per_page => 8, :page => params[:page])
  end
  helper_method :users

  def user
    @user ||= params[:id] ? User.find(params[:id]) : User.new(params[:user])
  end
  helper_method :user
end
