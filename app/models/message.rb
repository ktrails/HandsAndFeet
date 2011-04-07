# This class represents chat messages
class Message < ActiveRecord::Base
  attr_accessible :content
end
