require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    it "works! (now write some real specs)" do

      visit "log_in"
      if page.find_by_id("email")
        fill_in "email", :with => "test@test.com"
      else
        return false
      end
      fill_in "password", :with => "test"
      click_button "Save changes"
      click_link "Users"
      page.should have_content("List users")
    end
  end
end
