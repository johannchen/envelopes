require 'spec_helper'

describe "Envelopes" do
  let(:user) { Factory(:user_with_envelopes_and_transactions) }
  before do 
    login(user)
    visit envelopes_path 
  end

  describe "Overview" do
    context "with many envelopes" do
      it "displays monthly envelopes" do
        page.should have_content("Auto")
        page.should have_content("$250.00")
        page.should have_content("Current Amount")
        page.should have_content("$300.00")
        page.should have_content("Home")
        page.should have_content("$400.00")
        page.should have_content("Total")
        page.should have_content("$650.00")
        page.should have_content("-$150.00")
        page.should have_content("Current month income $3,000.00")
        page.should have_content("Current month expense $550.00")
        page.should have_content("Current month saving $2,450.00")
        page.should have_content("Total unallocate money $2,600.00")
      end
      it "displays annual/irregular envelopes" do
        click_link "Annual"
        page.should have_content("Tax")
        page.should have_content("$1,200.00")
        page.should have_content("Birthday")
        page.should have_content("$600.00")
        page.should have_content("Current Amount")
        page.should have_content("-$300.00")
        page.should have_content("Total")
        page.should have_content("$1,800.00")
        page.should have_content("Total unallocate money $2,600.00")
      end
      it "edits budget in place" do
      end
    end

  end

  describe "Add Envelope" do
    it "adds new envelope" do
      click_link "Add Envelope"
      fill_in "Name", :with => "Shopping"
      fill_in "Budget", :with => "400"
      choose "envelope_monthly_1"
      click_button "Save"
      page.should have_content("Shopping")
      page.should have_content("400")
    end
    it "adds envelope label" do
    end
  end

end
