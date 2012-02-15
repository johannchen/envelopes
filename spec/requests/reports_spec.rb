require 'spec_helper'

describe "Reports" do
 
  describe "Expense Breakdown" do
    let(:user) { Factory(:user_with_envelopes_and_transactions) }
    before do
      login(user)
      visit reports_expense_breakdown_path
    end
    it "displays expenses in pie chart by envelopes" do
    end
    it "shows pencentage and total" do
      page.should have_content("Auto")
      page.should have_content("$100.00")
      page.should have_content("18.18%")
      page.should have_content("Birthday")
      page.should have_content("$300.00")
      page.should have_content("54.55%")
      page.should have_content("$550.00")
    end
    it "filters report by date" do
    end
  end

  describe "Expense vs Budget" do
    it "compares percentage and amount within a year" do
    end
  end

  describe "Expense by Payee" do
    it "diplays expense in a pie chart by payees" do
    end
  end

  describe "Budget Allocation" do
    let(:user) { Factory(:user_with_envelopes) }
    before do
      login(user)
      visit reports_budget_allocation_path
    end 
    it "displays budget and percentage of each envelope" do
      page.should have_content("Auto")
      page.should have_content("$250.00")
      page.should have_content("25.00%")
      page.should have_content("Birthday")
      page.should have_content("$50.00")
      page.should have_content("5.00%")
      page.should have_content("$1,000.00")
    end
  end
end
