require 'spec_helper'

describe "Envelopes" do
  let(:user) { Factory(:user) }

  describe "Overview" do
    it "displays monthly envelopes" do
      e1 = Factory(:envelope, :user => user)
      e2 = Factory(:envelope, :name => "Home", :user => user)
      visit envelopes_path
      page.should have_content(e1.name)
      page.should have_content(e1.budget)
      page.should have_content(e2.name)
    end
    it "displays annual/irregular envelopes" do
      e1 = Factory(:envelope, :monthly => :false, :name => "Tax", :user => user)
      e2 = Factory(:envelope, :monthly => :false, :name => "Birthday", :user => user)
      visit envelopes_path
      click_link "Annual"
      page.should have_content(e1.name)
      page.should have_content(e1.budget)
      page.should have_content(e2.name)
    end
    it "displays recent transactions" do
      t1 = Factory(:transaction, :user => user)
      visit envelopes_path
      page.should have_content(t1.date)
      page.should have_content(t1.envelope.name)
      page.should have_content(t1.description)
      page.should have_content(t1.amount)
    end
  end

  describe "Edit Budgets" do
    it "edits monthly budget" do
    end
    it "edits annual budget" do
    end
    it "adds new envelope" do
    end
  end

  describe "Distribution" do
    it "allocates money to envelopes" do
    end 
  end

  describe "Transer Between Envelopes" do
    it "transfers money between two envelopes" do
    end
  end
end
