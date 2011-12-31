require 'spec_helper'

describe "Reports" do
  describe "Expense Breakdown" do
    before do
      Factory(:transaction, :amount => -400, :envelope_name => "Shopping")
      Factory(:transaction, :amount => -100, :envelope_name => "Food")
      visit reports_expense_breakdown_path
    end
    it "displays expenses in pie chart by envelopes" do
    end
    it "shows pencentage and total" do
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
    before do 
      Factory(:envelope, :name => "Food", :budget => 200)
      Factory(:envelope, :name => "Home", :budget => 700)
      Factory(:envelope, :name => "Tax", :budget => 1200, :monthly => false)
      visit reports_budget_allocation_path
    end 
    it "displays budget and percentage of each envelope", :focus => true do
      page.should have_content("Food")
      page.should have_content("$200.00")
      page.should have_content("20%")
      page.should have_content("Tax")
      page.should have_content("$100.00")
      page.should have_content("10%")
      page.should have_content("$1000.00")
    end
  end
end
