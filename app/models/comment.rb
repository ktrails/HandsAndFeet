# One or more Comments are added to a Post
class Comment < ActiveRecord::Base
  belongs_to :post
end
