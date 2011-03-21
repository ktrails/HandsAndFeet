require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test "save comment without commenter" do
    comment = Comment.new
    comment.body = "MyBody"
    assert !comment.save, "Saved comment without commenter"
  end

  test "save comment without body" do
    comment = Comment.new
    comment.commenter = "MyCommenter"
    assert !comment.save, "Saved comment without body"
  end

  test "save good comment" do
    comment = Comment.new
    comment.commenter = "MyCommenter"
    comment.body = "MyBody"
    assert comment.save, "Failed to save good comment"
  end

end
