require 'spec_helper'

describe Transaction do
  describe ".unallocated_amount" do
    context "both unallocated and allocated transantions" do
      it "calculates the total unallocated amount", :focus => true do
        Factory(:transaction, :amount => 100)
        Factory(:transaction, :allocated => true, :amount => 40)
        total_unallocated = Transaction.unallocated_amount
        total_unallocated.should == 60.00
      end
    end
  end
end
