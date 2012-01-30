module ReportsHelper
  def expense_of_months(envelope, months)
    envelope.months_expense(months)
  end

  def budget_of_months(envelope, months)
    if envelope.monthly
      envelope.budget.to_f * months
    else
      envelope.budget.to_f / 12 * months
    end
  end

  def expense_over_budget(envelope, months)
    expense_of_months(envelope, months) / budget_of_months(envelope, months) * 100
  end
end
