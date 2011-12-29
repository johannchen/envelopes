require 'spec_helper'

describe Envelope do
  describe "#current_amount" do
    context "with transactions" do
      envelope = Factory(:envelope)
      Factory(:transaction, :amount => -10, :envelope => envelope)
      Factory(:transaction, :amount => 30, :envelope => envelope)
      specify { envelope.current_amount.should == 20 }
    end
    context "without transactions" do
      envelope = Factory(:envelope)
      specify { envelope.current_amount.should == 0 }
    end
  end

  describe "#expense" do
    context "with transactions" do
      envelope = Factory(:envelope)
      Factory(:transaction, :amount => -10, :envelope => envelope)
      Factory(:transaction, :amount => -15, :envelope => envelope)
      Factory(:transaction, :amount => 30, :envelope => envelope)
      specify { envelope.expense.should == 25 }
    end
  end
end
