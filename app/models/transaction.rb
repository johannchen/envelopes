class Transaction < ActiveRecord::Base
  has_one :distribution
  belongs_to :envelope
  belongs_to :account
  belongs_to :user

  attr_reader :account_name
  attr_writer :envelope_name
  before_save :assign_envelope

  def self.unallocated_amount
    self.where("amount > 0 and allocated = false").sum("amount") - self.where("amount > 0 and allocated = true").sum("amount")
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
