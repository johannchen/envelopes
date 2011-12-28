class Envelope < ActiveRecord::Base
  has_many :transactions
  belongs_to :user

  def current_amount
    transactions.sum("amount").to_f
  end

end
