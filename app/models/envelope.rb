class Envelope < ActiveRecord::Base
  has_many :transactions
  belongs_to :user

  def current_amount
    transactions.sum("amount").to_f
  end

  def expense
    transactions.where("amount < 0").sum("amount").to_f.abs
  end
end
