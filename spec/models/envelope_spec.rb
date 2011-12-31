require 'spec_helper'

describe Envelope do
  let(:envelope) { Factory(:envelope_with_transactions) }
  describe "#expense" do
    context "with transactions" do
      specify { envelope.expense.should == 450 }
    end
  end

  describe "#current_amount" do
    context "with transactions" do
      specify { envelope.current_amount.should == 50 }
    end
    context "without transactions" do
      en = Factory(:envelope)
      specify { en.current_amount.should == 0 }
    end
  end

  describe ".total_budget" do
    context "with envelopes" do
      before do
        Factory(:envelope, :name => "Food", :budget => 200, :monthly => true)
        Factory(:envelope, :name => "Home", :budget => 800, :monthly => true)
      end
      specify { Envelope.total_budget.should == 1000 } 
    end
  end

  describe ".total_budget_by_month" do
    context "with annual envelopes" do
      before do
        Factory(:envelope, :name => "Food", :budget => 200, :monthly => true)
        Factory(:envelope, :name => "Home", :budget => 700, :monthly => true)
        Factory(:envelope, :name => "Tax", :budget => 1200, :monthly => false)
      end
      specify { Envelope.total_budget_by_month.should == 1000 } 
    end
  end
end
