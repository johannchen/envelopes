class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create

  has_many :envelopes 
  has_many :accounts
  has_many :transactions
  has_many :distributions

  def total_budget
    envelopes.where(:monthly => true).sum("budget").to_f
  end

  def total_budget_by_month
    total_budget + envelopes.where(:monthly => false).sum("budget") / 12
  end

  def total_monthly_current_amount
    envelopes.where(:monthly => true).inject(0.0) { |sum, e| sum + e.current_amount }
  end

  def recent_transactions
    transactions.order("date desc").limit(5)
  end

  def unallocated_amount
    transactions.total_income - transactions.total_allocated
  end
end
