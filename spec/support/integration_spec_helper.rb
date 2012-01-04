module IntegrationSpecHelper
  def login(user)
    user ||= Factory(:user)
    visit root_url
    fill_in "Email", :with => user.email 
    fill_in "Password", :with => user.password
    click_button "Log In"
  end
end
