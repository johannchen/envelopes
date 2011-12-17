require 'spec_helper'

describe "Transactions" do
  let(:user) { Factory(:user) }
  describe "Transaction History" do
    before { 26.times { Factory(:transaction, :user => user) } }

    it "paginates every 10 transactions by default" do
      visit transactions_path
      page.should have_no_link("Prev")
      page.should have_link("Next")
      click_link "Next"
      page.should have_link("Prev")
      page.should have_link("Next")
      click_link "Next"
      page.should have_link("Prev")
      page.should have_no_link("Next")
    end
    it "provides options of 25/50/100 for paginations" do
    end
    it "downloads as CSV" do 
    end
    it "filters results by envelope and date" do
    end
    it "filters results by search description and amount" do
    end
  end

  describe "Record Expense" do
    it "records expense and stay on the same form" do
      Factory(:envelope)
      visit transactions_path
      click_link "Record Expense"
      fill_in "Date", :with => Date.today
      fill_in "Description", :with => "Toyota"
      fill_in "Amount", :with => "500"
      select "Auto"
      fill_in "Note", :with => "car loan payment"
      click_button "Save"
      page.should have_content("Successfully recorded expense!")
      page.should have_content("Toyota")
      page.should have_content("500")
    end
  end

  describe "Add Income" do
    it "adds income without allocation", :focus => :true do
      visit transactions_path
      click_link "Add Income"
      fill_in "Date", :with => Date.today
      fill_in "Description", :with => "UCD"
      fill_in "Amount", :with => "1000"
      click_button "Save"
      page.should have_content("UCD")
      page.should have_content("+$1,000.00")
    end
    it "allocates specific amount to envelopes" do
      
    end
  end
end
