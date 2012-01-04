class ReportsController < ApplicationController
  def expense_breakdown
    @envelopes = Envelope.all
    #@total = 0
    #@envelopes.each do |e| 
    #  @total += e.expense
    #end
    @total = @envelopes.inject(0.0) { |result, envelope| envelope.expense + result }
  end

  def expense_vs_budget
  end

  def budget_allocation
    @envelopes = Envelope.all
    @total = Envelope.total_budget_by_month
  end
end
