require 'test_helper'

class PostTest < ActiveSupport::TestCase

  test "save post without content" do
    post = posts(:no_content)
    assert !post.save, "Saved post without content"
  end

  test "save post without name" do
    post = posts(:no_name)
    assert !post.save, "Saved post without a name"
  end

  test "save post without title" do
    post = posts(:no_title)
    assert !post.save, "Saved post without a title"
  end

  test "save post with short title" do
    post = posts(:short_title)
    assert !post.save, "Saved post with a short title"
  end

  test "save post with valid fields" do
    post = posts(:good)
    assert post.save, "Failed to save post with valid fields"
  end

  test "save post again after shortening title" do
    post = posts(:good)
    assert post.save, "Failed to saved post with valid fields"
    post.title = 'Tiny'
    assert !post.save, "Saved post with shortened title"
  end

  test "post has one comment" do
    post = posts(:post_with_comment)
    assert post.comments.count == 1, "Post doesn't have a comment"
    assert post.save, "Post with a comment would not save"
  end

  test "post has two comments" do
    post = posts(:post_with_comments)
    assert post.comments.count == 2, "Post doesn't have two comments"
    assert post.save, "Post with two comments would not save"
  end

  test "post can delete comments" do
    post = posts(:post_with_comments)
    assert post.comments.count == 2, "Post doesn't have two comments"
    comment = post.comments.find(2)
    comment.destroy
    comment = post.comments.find(3)
    comment.destroy
    assert post.comments.count == 0, "Post has non-zero comment count"
  end

end
