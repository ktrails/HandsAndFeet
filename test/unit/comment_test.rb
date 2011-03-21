require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test "save comment without commenter" do
    comment = comments(:no_commenter)
    assert !comment.save, "Saved comment without commenter"
  end

  test "save comment without body" do
    comment = comments(:no_body)
    assert !comment.save, "Saved comment without body"
  end

  test "save good comment" do
    comment = comments(:good)
    assert comment.save, "Failed to save good comment"
  end

end
