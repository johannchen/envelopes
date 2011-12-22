require 'spec_helper'

describe "Envelopes" do
  let(:user) { Factory(:user) }
  before { visit envelopes_path }

  describe "Overview" do
    context "with many envelopes" do
      let(:e1) { Factory(:envelope, :user => user) }
      let(:e2) { Factory(:envelope, :name => "Home", :user => user) }
      let(:e3) { Factory(:envelope, :monthly => :false, :name => "Tax", :user => user) }
      let(:e4) { Factory(:envelope, :monthly => :false, :name => "Birthday", :user => user) }
      it "displays monthly envelopes" do
        page.should have_content(e1.name)
        page.should have_content(e1.budget)
        page.should have_content(e2.name)
      end
      it "displays annual/irregular envelopes" do
        click_link "Annual"
        page.should have_content(e3.name)
        page.should have_content(e3.budget)
        page.should have_content(e4.name)
      end
      it "edits budget in place" do
      end
    end
    it "displays recent transactions" do
      t1 = Factory(:transaction, :user => user)
      page.should have_content(t1.date)
      page.should have_content(t1.envelope.name)
      page.should have_content(t1.description)
      page.should have_content(t1.amount)
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

  describe "Transer Between Envelopes" do
    it "transfers money between two envelopes" do
    end
  end
end
