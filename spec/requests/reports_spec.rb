require 'spec_helper'

describe "Reports" do
 
  describe "Expense Breakdown" do
    let(:user) { Factory(:user_with_transactions) }
    before do
      login(user)
      visit reports_expense_breakdown_path
    end
    it "displays expenses in pie chart by envelopes" do
    end
    it "shows pencentage and total", :focus => true do
      page.should have_content("Shopping")
      page.should have_content("$400.00")
      page.should have_content("80%")
      page.should have_content("Food")
      page.should have_content("$100.00")
      page.should have_content("20%")
      page.should have_content("$500.00")
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
    it "displays budget and percentage of each envelope", :focus => true do
      page.should have_content("Home")
      page.should have_content("$600.00")
      page.should have_content("60%")
      page.should have_content("Tax")
      page.should have_content("$100.00")
      page.should have_content("10%")
      page.should have_content("$1,000.00")
    end
  end
end
