# One or more Comments are added to a Post
class Comment < ActiveRecord::Base
  belongs_to :post

  validates :commenter, :presence => true
  validates :body,      :presence => true
end
