require 'spec_helper'

describe "Transactions" do
  let(:user) { Factory(:user) }
  before { visit transactions_path }
  describe "Transaction History" do
    before { 26.times { Factory(:transaction, :user => user) } }

    it "paginates every 10 transactions by default" do
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
      click_link "Record Expense"
      fill_in "Date", :with => Date.today
      fill_in "Name", :with => "Toyota"
      fill_in "Amount", :with => "500"
      select "Auto"
      fill_in "Description", :with => "car loan payment"
      click_button "Save"
      page.should have_content("Successfully recorded expense!")
      page.should have_content("Toyota")
      page.should have_content("500")
    end
  end

  describe "Add Income" do
    it "adds income without allocation", :focus => :true do
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

  describe "Upload Transactions with account" do
    let(:account) { Factory(:account) }
    context "with a valid csv file" do
      it "uploads transactions from csv file", :focus => :true do
        click_link "Upload Transactions"
        attach_file "File", "/home/vadmin/Downloads/history.csv"
        select account.name
        click_button "Upload"
        page.should have_content "Successfully uploaded transactions!"
      end
      it "creates envelope when envelope does not exist" do
      end
    end
    context "with a invalid csv file" do
      it "generates error message" do
      end
    end
  end
end
