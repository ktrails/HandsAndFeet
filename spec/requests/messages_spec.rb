require 'spec_helper'

describe "Messages" do
  describe "GET /messages" do
    it "works! (now write some real specs)" do
      visit "log_in"
      fill_in "Email", :with => "test@test.com"
      fill_in "Password", :with => "test"
      click_button "Save changes"
      click_link "Users"
      page.should have_content("List users")
    end
  end
end
