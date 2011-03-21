require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "save user without firstname" do
    user = User.new
    user.lastname = 'no_firstname'
    user.email = 'no_firstname'
    assert !user.save, "Saved user without a firstname"
  end

  test "save user without lastname" do
    user = User.new
    user.firstname = 'no_lastname'
    user.email = 'no_lastname'
    assert !user.save, "Saved user without a lastname"
  end

  test "save user without email" do
    user = User.new
    user.firstname = 'no_email'
    user.lastname = 'no_email'
    assert !user.save, "Saved user without an email"
  end

  test "save valid user" do
    user = User.new
    user.firstname = "good"
    user.lastname = "good"
    user.email = "good"
    user.password = 'good'
    user.encrypt_password
    assert user.save, "Failed to save valid user"
  end

  test "save valid user duplicate" do
    user = users(:dup_test)
    user.password = "duplicate"
    user.encrypt_password
    assert user.save, "Failed to save valid user"
    user = User.new
    user.firstname = "unique"
    user.lastname = "unique"
    user.email = "duplicate"
    user.password = 'unique'
    user.encrypt_password
    assert !user.save, "Saved duplicate user"
  end

end
