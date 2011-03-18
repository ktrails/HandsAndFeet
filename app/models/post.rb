# A Blog consists of a collection of Posts, each with zero or more Comments
class Post < ActiveRecord::Base
  validates :name,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 5 }
  
  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end
