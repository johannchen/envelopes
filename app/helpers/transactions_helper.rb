module TransactionsHelper
  def format_amount(transaction)
    if transaction.income 
      "+" + number_to_currency(transaction.amount) 
    else
      number_to_currency(transaction.amount)
    end
  end
end
