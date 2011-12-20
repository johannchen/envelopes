module TransactionsHelper
  def format_amount(amount)
    if amount < 0 
      "+" + number_to_currency(amount.abs) 
    else
      number_to_currency(amount)
    end
  end
end
