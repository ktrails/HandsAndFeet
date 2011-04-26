require 'spec_helper'

describe "Posts" do

  describe "GET /posts" do
    it "should list posts" do
      visit "posts"
      page.should have_content("List Posts")
    end
  end

  describe "GET /posts" do

    before(:each) do
      user = Factory.create(:user,
        :email => 'test@test.com',
        :password => 'test')
      user.save
      visit "log_in"
      fill_in "email", :with => 'test@test.com'
      fill_in "password", :with => 'test'
      click_on('Save changes')
      click_on('Posts')
      click_on('New post')
    end

    describe "POST /posts" do
      it "it won't work with a blank name" do
        click_on 'Create Post'
        page.should have_content("Form is invalid")
        page.should have_content("Name can't be blank")
      end
    end

    describe "POST /posts" do
      it "it won't work with a blank title" do
        click_on 'Create Post'
        fill_in "Name", :with => "test"
        page.should have_content("Form is invalid")
        page.should have_content("Title can't be blank")
      end
    end

    describe "POST /posts" do
      it "it won't work with a short title" do
        click_on 'Create Post'
        fill_in "Name", :with => "test"
        fill_in "Title", :with => "test"
        page.should have_content("Form is invalid")
        page.should have_content("Title is too short (minimum is 5 characters)")
      end
    end

    describe "POST /posts" do
      it "it won't work with blank content" do
        click_on 'Create Post'
        fill_in "Name", :with => "test"
        fill_in "Title", :with => "title"
        page.should have_content("Form is invalid")
        page.should have_content("Content can't be blank")
      end
    end

    describe "POST /posts" do
      it "should create a post" do
        fill_in "Name", :with => 'Name'
        fill_in "Title", :with => 'Title of post'
        fill_in "Content", :with => 'Content of post'
        click_on 'Create Post'
        page.should have_content('Post was successfully created.')
      end
    end

  end
end
