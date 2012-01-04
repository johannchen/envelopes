class ReportsController < ApplicationController
  skip_authorization_check

  def expense_breakdown
    @envelopes = current_user.envelopes 
    #@total = 0
    #@envelopes.each do |e| 
    #  @total += e.expense
    #end
    @total = @envelopes.inject(0.0) { |result, envelope| envelope.expense + result }
  end

  def expense_vs_budget
  end

  def budget_allocation
    @envelopes = current_user.envelopes 
    @total = current_user.total_budget_by_month
  end
end
