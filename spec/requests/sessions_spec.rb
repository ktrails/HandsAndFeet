require 'spec_helper'

describe "Sessions" do

  before(:each) do
    user = Factory.create(:user,
      :email => 'test@test.com',
      :password => 'test')
    user.save
    visit "log_in"
  end

  describe "POST /login" do
    it "should not allow a missing username" do
      fill_in "password", :with => 'test'
      click_on('Save changes')
      page.should have_content("Invalid email or password")
    end
  end

  describe "POST /login" do
    it "should not allow a missing password" do
      fill_in "email", :with => 'test@test.com'
      click_on('Save changes')
      page.should have_content("Invalid email or password")
    end
  end

  describe "POST /login" do
    it "should not allow an invalid login" do
      fill_in "email", :with => 'test@test.com'
      fill_in "password", :with => 'fail'
      click_on('Save changes')
      page.should have_content("Invalid email or password")
    end
  end

  describe "POST /login" do
    it "should allow a valid login" do
      fill_in "email", :with => 'test@test.com'
      fill_in "password", :with => 'test'
      click_on('Save changes')
      page.should have_content("Logged in!")
    end
  end

end
