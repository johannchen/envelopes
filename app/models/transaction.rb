class Transaction < ActiveRecord::Base
  belongs_to :envelope
  belongs_to :account
  belongs_to :user

  attr_writer :envelope_name
  before_save :assign_envelope

  def envelope_name
    @envelope_name || envelope.name if envelope
  end

  private

  def assign_envelope
    if @envelope_name
      self.envelope = Envelope.find_or_create_by_name(@envelope_name)
    end
  end
end
