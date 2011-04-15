require 'spec_helper'

describe "Users" do

  describe "GET /users" do
    it "should be a sign up form" do
      visit "sign_up"
      page.should have_content("Sign up")
    end
  end
end

describe "Users" do

  before(:each) do
    user = Factory.create(:user)
    visit "sign_up"
  end

  describe "POST /users" do
    it "won't work with a blank Firstname" do
      click_on('Create User')
      page.should have_content("Firstname can't be blank")
    end
  end

  describe "POST /users" do
    it "won't work with a blank Lastname" do
      fill_in "Firstname", :with => "first"
      click_on('Create User')
      page.should have_content("Lastname can't be blank")
    end
  end

  describe "POST /users" do
    it "won't work with a blank Email" do
      fill_in "Firstname", :with => "first"
      fill_in "Lastname", :with => "last"
      click_on('Create User')
      page.should have_content("Email can't be blank")
    end
  end

  describe "POST /users" do
    it "won't work with a blank Password" do
      fill_in "Firstname", :with => "first"
      fill_in "Lastname", :with => "last"
      fill_in "Email", :with => "first.last@gmail.com"
      click_on('Create User')
      page.should have_content("Password can't be blank")
    end
  end

  describe "POST /users" do
    it "won't work with a blank Password confirmation" do
      fill_in "Firstname", :with => "first"
      fill_in "Lastname", :with => "last"
      fill_in "Email", :with => "first.last@gmail.com"
      fill_in "Password", :with => "first"
      click_on('Create User')
      page.should have_content("Password doesn't match confirmation")
    end
  end

  describe "POST /users" do
    it "won't work with a different Password confirmation" do
      fill_in "Firstname", :with => "first"
      fill_in "Lastname", :with => "last"
      fill_in "Email", :with => "first.last@gmail.com"
      fill_in "Password", :with => "first"
      fill_in "Password confirmation", :with => "different"
      click_on('Create User')
      page.should have_content("Password doesn't match confirmation")
    end
  end
end

describe "Users" do

  before(:each) do
    visit "sign_up"
  end

  describe "POST /users" do
    it "should not allow duplicate emails" do
      user = Factory.create(:user,
        :firstname => "first",
        :lastname => "last",
        :email => "first.last@gmail.com",
        :password => "first",
        :password_confirmation => "first")
      user.save
      fill_in "Firstname", :with => "first"
      fill_in "Lastname", :with => "last"
      fill_in "Email", :with => "first.last@gmail.com"
      fill_in "Password", :with => "first"
      fill_in "Password confirmation", :with => "first"
      click_on('Create User')
      page.should have_content("Email has already been taken")
    end
  end

  describe "POST /users" do
    it "should allow a unique entry" do
      user = Factory.create(:user)
      visit "sign_up"
      fill_in "Firstname", :with => "first"
      fill_in "Lastname", :with => "last"
      fill_in "Email", :with => "first.last@email.com"
      fill_in "Password", :with => "first"
      fill_in "Password confirmation", :with => "first"
      click_on('Create User')
      page.should have_content("Signed up!")
    end
  end
end
