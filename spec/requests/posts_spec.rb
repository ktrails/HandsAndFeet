require 'spec_helper'

describe "Posts" do
  describe "GET /posts" do
    it "works! (now write some real specs)" do
      visit "log_in"
      fill_in "email", :with => "test@test.com"
      fill_in "password", :with => "test"
      click_button "Save changes"
      click_link "Users"
      page.should have_content("List users")
    end
  end
end
