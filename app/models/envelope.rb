class Envelope < ActiveRecord::Base
  has_many :transactions
  belongs_to :user

  attr_reader :name_amount

  validates_presence_of :name, :user
  validates_numericality_of :budget
  validates_uniqueness_of :name, :scope => :user_id
  
  scope :active, where(:active => true)
  scope :monthly, where(:monthly => true)
  scope :annual, where(:monthly => false)

  def current_amount
    transactions.sum("amount").to_f
  end

  def name_amount
    @name_amount || "#{name} : #{current_amount}"
  end

  def refill_amount
    refill = budget.to_f - current_amount
    refill < 0 ? 0.0 : refill.round(2)
  end

  def period_expense(start_date, end_date)
    transactions.period(start_date, end_date).where("amount < 0").sum("amount").to_f.abs if start_date and end_date 
  end

  def months_expense(months=1)
    transactions.months_ago(months).where("amount < 0").sum("amount").to_f.abs
  end

  def monthly_budget
    monthly ? budget.to_f : budget.to_f / 12
  end
end
