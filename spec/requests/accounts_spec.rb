require 'spec_helper'

describe "Accounts" do
  let(:user) { Factory(:user) }
  before do
    login(user)
    visit accounts_path 
  end

  describe "Overview" do
    context "with no account" do
      it "displays instruction to add account" do
      end
    end

    context "with many accounts" do
      it "displays all account balances" do
      end
    end

    context "with one account" do
      it "edits account in place" do
      end
    end
  end

  describe "Add Account" do
    it "adds new account", :focus => true do
      click_link "Add Account"
      fill_in "Name", :with => "BOA"
      fill_in "Note", :with => "checking account"
      click_button "Save"
      page.should have_content("BOA")
      page.should have_content("checking account")
    end
  end
end
