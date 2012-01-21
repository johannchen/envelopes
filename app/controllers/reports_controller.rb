class ReportsController < ApplicationController
  skip_authorization_check

  def expense_breakdown
    @envelopes = current_user.envelopes 
    @total = @envelopes.inject(0.0) { |result, e| e.expense + result }
    rows = @envelopes.map { |e| [e.name, e.expense] } 
    @chart = pie_chart(rows, 'Envelope', 'Amount', 'Expense Breakdown') 
  end

  def expense_vs_budget
    @envelopes = current_user.envelopes 
    @total_expense = current_user.total_expense
    @total_budget = @envelopes.sum("budget")
    @total_percentage = @total_expense / @total_budget * 100
    rows = @envelopes.map { |e| [e.name, e.expense, e.budget.to_f] } 
    @chart = bar_chart(rows, 'Envelope', 'Expense', 'Budget', 'Expense vs Budget') 
  end

  def budget_allocation
    @envelopes = current_user.envelopes 
    @total = current_user.total_budget_by_month
    rows = @envelopes.map { |e| e.monthly ? [e.name, e.budget.to_f] : [e.name, e.budget.to_f/12] } 
    @chart = pie_chart(rows, 'Envelope', 'Amount', 'Budget Allocation') 
  end

  private

  def pie_chart(rows, col1, col2, title)
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', col1)
    data_table.new_column('number', col2)
    data_table.add_rows(rows)
    options = { width: 600, height: 360, title: title, is3D: false}
    chart = GoogleVisualr::Interactive::PieChart.new(data_table, options)
  end

  def bar_chart(rows, col1, col2, col3, title)
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', col1)
    data_table.new_column('number', col2)
    data_table.new_column('number', col3)
    data_table.add_rows(rows)
    options = { width: 600, height: 360, title: title, vAxis: {title: title, titleTextStyle: {color: 'red'}}}
    chart = GoogleVisualr::Interactive::BarChart.new(data_table, options)
  end

end

