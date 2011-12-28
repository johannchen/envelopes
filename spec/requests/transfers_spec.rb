require 'spec_helper'

describe "Transfers" do
  describe "Transer Between Envelopes" do
    it "transfers money between two envelopes", :focus => true do
      t1 = Factory(:transaction, :envelope_name => "Shopping", :amount => 50)
      t2 = Factory(:transaction, :envelope_name => "Saving", :amount => 400)
      visit new_transfer_path 
      fill_in "date", :with => Date.today 
      fill_in "description", :with => "Need more money in Shopping"
      fill_in "amount", :with => "200"
      select "Saving", :from => "from"
      select "Shopping", :from => "to"
      click_button "Transfer"
      page.should have_content("Successfully transfer money")
      page.should have_content("200")
      page.should have_content("250")
    end
  end
end
