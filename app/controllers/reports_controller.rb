class ReportsController < ApplicationController
  def expense_breakdown
    @envelopes = Envelope.all
  end

  def expense_vs_budget
  end
end
