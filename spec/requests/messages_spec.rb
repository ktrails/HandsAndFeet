require 'spec_helper'

describe "Messages" do
  describe "GET /messages" do
    it "won't let you chat without logging in" do
      visit "log_in"
      click_link "Chat"
      page.should have_content("You need to log in first.")
    end
  end

  describe "POST /messages" do

    before(:each) do
      user = Factory.create(:user,
        :email => 'test@test.com',
        :password => 'test')
      user.save
      visit "log_in"
      fill_in "email", :with => 'test@test.com'
      fill_in "password", :with => 'test'
      click_on('Save changes')
      click_on('Chat')
    end

    describe "GET /messages" do
      it "should be on Chat page" do
        page.should have_content("Chat")
      end
    end
    describe "GET /messages" do
      it "will let you post" do
        fill_in "message[content]", :with => "a chat test message"
        save_and_open_page()
        click_on('message_submit')
        page.should have_content("a chat test message")
      end
    end
  end
end