class ReportsController < ApplicationController
  def expense_breakdown
    @envelopes = Envelope.all
    @total = 0
    @envelopes.each do |e| 
      @total += e.expense
    end
  end

  def expense_vs_budget
  end
end
