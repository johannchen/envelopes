class Envelope < ActiveRecord::Base
  has_many :transactions
  belongs_to :user

  def self.total_budget
    where(:monthly => true).sum("budget").to_f
  end

  def self.total_budget_by_month
    total_budget + where(:monthly => false).sum("budget") / 12
  end

  def current_amount
    transactions.sum("amount").to_f
  end

  def expense
    transactions.where("amount < 0").sum("amount").to_f.abs
  end

end
