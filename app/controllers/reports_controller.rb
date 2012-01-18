class ReportsController < ApplicationController
  skip_authorization_check

  def expense_breakdown
    @envelopes = current_user.envelopes 
    #@total = 0
    #@envelopes.each do |e| 
    #  @total += e.expense
    #end
    @total = @envelopes.inject(0.0) { |result, envelope| envelope.expense + result }
    # pie chart
    rows = @envelopes.map { |envelope| [envelope.name, envelope.expense] } 
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Envelope')
    data_table.new_column('number', 'Amount')
    data_table.add_rows(rows)
    options = { width: 400, height: 240, title: 'Expense Breakdown', is3D: true }
    @chart = GoogleVisualr::Interactive::PieChart.new(data_table, options)
  end

  def expense_vs_budget
  end

  def budget_allocation
    @envelopes = current_user.envelopes 
    @total = current_user.total_budget_by_month
  end
end
