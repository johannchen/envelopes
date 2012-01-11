require 'spec_helper'

describe "Distributions" do
  let(:user) { Factory(:user_with_envelopes_and_transactions) }
  before do 
    login(user)
  end

  describe "New distribution" do
    context "without envelope" do
      it "displays message to add envelope" do
      end
    end
    context "with envelopes" do
      it "allocates money to envelopes", :focus => true do
        visit envelopes_path
        click_link "Distribution"
        current_path.should eq(envelopes_path)
        page.should have_content("You currently have $1,000.00 in Unallocated Money") 
        fill_in "Date", :with => Date.today
        fill_in "Name", :with => "My Paycheck"
        fill_in "Amount", :with => 800
        fill_in "Auto", :with => 500
        fill_in "Home", :with => 300
        click_button "Save"
        page.should have_content("Successfully distributed money")
        page.should have_content(Date.today)
        page.should have_content("300")
        page.should have_content("500")
        click_link "Distribution"
        page.should have_content("200")
        
      end 
    end
  end
end
