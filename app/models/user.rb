class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password

  validates_presence_of :name, :email
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email

  has_many :envelopes 
  has_many :accounts
  has_many :transactions
  has_many :distributions

  def total_budget
    envelopes.monthly.sum("budget").to_f
  end

  def total_budget_by_month
    total_budget + envelopes.annual.sum("budget") / 12
  end

  def total_expense(start_date, end_date)
    envelopes.inject(0.0) { |sum, e| sum + e.expense(start_date, end_date) } if start_date and end_date
  end

  def total_monthly_current_amount
    envelopes.monthly.inject(0.0) { |sum, e| sum + e.current_amount }
  end

  def total_annual_current_amount
    envelopes.annual.inject(0.0) { |sum, e| sum + e.current_amount }
  end

  def total_refill_amount
    envelopes.inject(0.0) { |sum, e| sum + e.refill_amount }
  end

  def recent_transactions
    transactions.unallocated.order("date desc").limit(5)
  end

  def unallocated_amount
    transactions.total_income - transactions.total_allocated
  end
end
