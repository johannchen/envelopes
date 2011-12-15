class EnvelopesController < ApplicationController
  def index
    @monthly_envelopes = Envelope.where(:monthly => :true)
    @annual_envelopes = Envelope.where(:monthly => :false)
    # TODO: list last 7 transactions
    @recent_transactions = Transaction.all
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end

end
