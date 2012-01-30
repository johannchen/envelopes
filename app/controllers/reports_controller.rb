class ReportsController < ApplicationController
  # authorize_resource :class => false

  def expense_breakdown
    authorize! :read, :reports
    params[:start_date] ? @start_date = params[:start_date] : @start_date = Date.today.at_beginning_of_month
    params[:end_date] ? @end_date = params[:end_date] : @end_date = Date.today.at_beginning_of_month.next_month
    @envelopes = current_user.envelopes.order("name") 
    @total = @envelopes.inject(0.0) { |result, e| e.period_expense(@start_date, @end_date) + result }
    rows = @envelopes.map { |e| [e.name, e.period_expense(@start_date, @end_date)] } 
    @chart = pie_chart(rows, 'Envelope', 'Amount', "Expense Breakdown #{@start_date} to #{@end_date}") 
  end

  def expense_vs_budget
    authorize! :read, :reports
    params[:months] ? @months = params[:months].to_i : @months = 1 
    start_date = @months.months.ago.at_beginning_of_month.strftime("from %Y-%m-%d")
    @envelopes = current_user.envelopes.order("name") 
    @total_expense = current_user.total_months_expense(@months)
    @total_budget = @envelopes.sum("budget") * @months
    @total_percentage = @total_expense / @total_budget * 100
    rows = @envelopes.map { |e| [e.name, e.budget.to_f * @months, e.months_expense(@months)] } 
    @chart = bar_chart(rows, 'Envelope', 'Budget', 'Expense', "Expense vs Budget #{start_date} to #{Date.today.at_beginning_of_month}") 
  end

  def budget_allocation
    authorize! :read, :reports
    @envelopes = current_user.envelopes.order("name") 
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
    options = { width: 600, height: 540, title: title }
    chart = GoogleVisualr::Interactive::BarChart.new(data_table, options)
  end

end

