class Transaction < ActiveRecord::Base
  require 'csv'
  has_one :distribution
  belongs_to :envelope
  belongs_to :account
  belongs_to :user

  validates_presence_of :date, :name, :amount

  self.per_page = 25
  attr_reader :account_name
  attr_writer :envelope_name
  before_save :assign_envelope

  scope :income, where("amount > 0 and allocated = false and excluded = false")
  scope :expense, where("amount < 0 and allocated = false and excluded = false")
  scope :allocated , where("allocated = true")
  scope :unallocated , where("allocated = false")
  scope :excluded , where("excluded = true")
  scope :period, lambda { |start_date, end_date| where("date >= :start_date and date < :end_date", {:start_date => start_date, :end_date => end_date}) }
  scope :current_month, lambda { where("date >= :start_date and date < :end_date", {:start_date => Date.today.at_beginning_of_month, :end_date => Date.today.at_beginning_of_month.next_month}) }
  scope :months_ago, lambda { |n| where("date >= :start_date and date < :end_date", {:start_date => n.months.ago.at_beginning_of_month, :end_date => Date.today.at_beginning_of_month}) }
  scope :months_ago_till_now, lambda { |n| where("date >= :start_date and date < :end_date", {:start_date => n.months.ago.at_beginning_of_month, :end_date => Date.today.at_beginning_of_month.next_month}) }

  def self.total_income
    income.sum("amount")
  end

  def self.total_expense
    expense.sum("amount")
  end

  def self.total_allocated
    allocated.sum("amount")
  end

  def self.search(name)
    where(['lower(name) like ?', "%#{name.downcase}%"]) if name
  end

  def envelope_name
    @envelope_name || envelope.name if envelope
  end

  def account_name
    @account_name || account.name if account
  end

  private

  def assign_envelope
    if @envelope_name
      self.envelope = Envelope.find_or_create_by_name_and_user_id(@envelope_name, self.user_id)
    end
  end
end
