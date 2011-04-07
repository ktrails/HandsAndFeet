class MessagesController < ApplicationController

  before_filter :logged_in?

  def index
    @messages = Message.all
  end

  def create
    @message = Message.create(params[:message])
    respond_to do |format|
      format.html { redirect_to :action => 'index' }
      format.js
    end
  end
end
