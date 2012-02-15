require 'spec_helper'

describe "Distributions" do
  describe "New distribution" do
    context "without no income and envelope" do
      let(:user) { Factory(:user) }
      before do 
        login(user)
      end
      it "displays message to add income and envelope", :focus => true do
        visit envelopes_path
        click_link "Distribution"
        page.should have_content("You currently have $0.00 in Unallocated Money") 
        page.should have_content("Please add income and add envelopes")
      end
    end

    context "with envelopes and income" do
      let(:user) { Factory(:user_with_envelopes_and_transactions) }
      before do 
        login(user)
      end
      it "allocates money to envelopes", :focus => true do
        visit envelopes_path
        click_link "Distribution"
        page.should have_content("You currently have $2,600.00 in Unallocated Money") 
        page.should have_content("$300.00/$250.00")
        page.should have_content("-$150.00/$400.00")
        page.should have_content("$0.00/$1,200.00")
        page.should have_content("-$300.00/$600.00")
        find_field("Amount").value.to_f.should == user.total_refill_amount
        find_field("Auto").value.to_f.should == 0
        find_field("Home").value.to_f.should == 550
        fill_in "Date", :with => Date.today
        fill_in "Name", :with => "My Paycheck"
        fill_in "Amount", :with => 600
        fill_in "Auto", :with => 0
        fill_in "Home", :with => 600
        click_button "Save"
        page.should have_content("Successfully distributed money")
        click_link "Distribution"
        page.should have_content("-$100.00")
        
      end 
      it "validates amount input before submit" do
      end
    end
  end
end
