require 'spec_helper'

describe "Distributions" do
  describe "New distribution" do
    context "without envelope" do
      it "displays message to add envelope" do
      end
    end
    context "with envelopes" do
      it "allocates money to envelopes", :focus => true do
        auto = Factory(:envelope, :name => "Auto", :budget => 600)
        home = Factory(:envelope, :name => "Home", :budget => 1000)
        paycheck = Factory(:transaction, :name => "UCD", :amount => 1000)
        visit new_distribution_path
        page.should have_content("You currently have $1,000.00 in Unallocated Money") 
        fill_in "Date", :with => Date.today
        fill_in "Name", :with => "My Paycheck"
        fill_in "Amount", :with => 800
        fill_in auto.name, :with => 400
        fill_in home.name, :with => 200
        click_button "Save"
        page.should have_content("Successfully distributed money")
        page.should have_content("200")
        
      end 
    end
  end
end
