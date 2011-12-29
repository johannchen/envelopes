require 'spec_helper'

describe ReportsController do

  describe "GET 'expense_breakdown'" do
    it "returns http success" do
      get 'expense_breakdown'
      response.should be_success
    end
  end

  describe "GET 'expense_vs_budget'" do
    it "returns http success" do
      get 'expense_vs_budget'
      response.should be_success
    end
  end

end
