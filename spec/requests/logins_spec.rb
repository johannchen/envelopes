require 'spec_helper'

describe "Logins" do
  describe "Authentication" do
    it "shows invalid user error message", :focus = true do
      visit root_url
      fill_in "Email", :with => "whatever@mail.com" 
      fill_in "Password", :with => "whatever" 
      click_button "Log In"
      page.should have_content("Invalid email or password") 
    end

    it "signs up new user" do
      visit root_url
      page.should have_link("sign up")
      click_link "sign up"
      fill_in "Name", :with => "johann"
      fill_in "Email", :with => "johannchen@example.com"
      fill_in "Password", :with => "secret"
      fill_in "Password confirmation", :with => "secret"
      click_button "Sign Up"
      page.should have_content("Signed up!")
    end

    it "Login and logout", :focus => true do
      user = Factory(:user)
      visit root_url
      fill_in "Email", :with => user.email 
      fill_in "Password", :with => user.password
      click_button "Log In"
      page.should have_content("Logged in!")
      # page.should have_content(user.email)
      page.should have_link("Log out")
      current_path.should eq(envelopes_path)
      click_link "Log out"
      page.should have_content("Logged out!")
    end
  end
end
