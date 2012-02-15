require 'spec_helper'

describe "Transfers" do
  let(:user) { Factory(:user_with_envelopes_and_transactions) }
  before do 
    login(user)
  end

  describe "Transer Between Envelopes" do
    it "transfers money between two envelopes", :focus => true do
      visit envelopes_path 
      click_link "Transfer"
      fill_in "transfer_date", :with => Date.today 
      fill_in "name", :with => "Need more money for Home"
      fill_in "amount", :with => "250"
      select "Auto", :from => "from"
      select "Home", :from => "to"
      click_button "Transfer"
      page.should have_content("Successfully transfer money")
      page.should have_content("$50")
      page.should have_content("$250")
    end
  end
end
