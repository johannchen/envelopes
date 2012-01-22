module TransactionsHelper
  def amount_color(transaction)
    if transaction.excluded
      "yellow"
    elsif transaction.allocated
      "purple"
    elsif transaction.amount > 0
      "green"
    else
      "money"
    end 
  end
end
