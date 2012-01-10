require 'spec_helper'

describe "Transactions" do
  let(:user) { Factory(:user_with_accounts_and_envelopes_and_transactions) }
  before do 
    login(user)
  end

  describe "Transaction History" do
    it "paginates every 10 transactions by default" do
      26.times { Factory(:transaction, :user => user) } 
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
    it "removes transaction" do
    end
    it "downloads as CSV" do 
    end
  end

  describe "Filter Results" do
    it "filters results by envelope and date, and displays blance" do
    end
    it "filters results by search description and amount" do
    end
  end

  describe "Record Transaction" do
    it "records expense and stay on the same form", :focus => true do
      visit transactions_path 
      click_link "Record Transaction"
      fill_in "Date", :with => Date.today
      fill_in "Name", :with => "Toyota"
      fill_in "Amount", :with => "500"
      select "Auto", :from => "transaction_envelope_id"
      select "BOA", :from => "transaction_account_id"
      fill_in "Description", :with => "car loan payment"
      click_button "Save"
      page.should have_content("Successfully recorded expense!")
      page.should have_content("Toyota")
      page.should have_content("-$500.00")
    end

    it "adds income without allocation", :focus => true do
      visit transactions_path 
      click_link "Record Transaction"
      choose "income_1"
      fill_in "Date", :with => Date.today
      fill_in "Name", :with => "UCD"
      fill_in "Amount", :with => "1000"
      select "BOA", :from => "transaction_account_id"
      click_button "Save"
      page.should have_content("UCD")
      page.should have_content("$1,000.00")
      page.should have_no_content("-$1,000.00")
    end
  end

  describe "Add Income" do
    it "allocates specific amount to envelopes" do
      
    end
  end

  describe "Upload Transactions with account" do
    context "with a valid csv file" do
      it "uploads transactions from csv file" do
        account = Factory(:account, :user => user)
        visit transactions_path 
        click_link "Upload Transactions"
        #TODO: put test file in test folder
        attach_file "transaction_file", "/home/vadmin/Downloads/history_valid.csv"
        # note a bug with select
        select account.name, :from => "account_id"
        click_button "Upload"
        page.should have_content "Successfully uploaded transactions!"
        page.should have_content "Breakpoint"
        page.should have_content "Gifts"
      end
      it "displays progress bar while uploading" do
      end
    end
    context "with a invalid csv file" do
      it "generates error message" do
      end
    end
  end

  describe "Edit Transaction" do
    it "edits transaction in place" do
    end
    it "assigns envelope in dropdown" do
    end
  end
end
