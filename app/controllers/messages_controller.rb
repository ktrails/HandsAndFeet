# This class represents the controller for chat messages
class MessagesController < ApplicationController

  before_filter :logged_in?

  def index
    @messages = Message.all
  end

  def create
    @message = Message.create(params[:message])
  end
end
