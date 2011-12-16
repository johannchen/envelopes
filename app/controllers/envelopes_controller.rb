class EnvelopesController < ApplicationController
  def index
    @monthly_envelopes = Envelope.where(:monthly => :true)
    @annual_envelopes = Envelope.where(:monthly => :false)
    @envelope = Envelope.new
    # TODO: list last 7 transactions
    @recent_transactions = Transaction.all
  end

  def new
  end

  def create
    @envelope = Envelope.new(params[:envelope])
    if @envelope.save
      redirect_to envelopes_path, notice: 'Sucessfully added envelope!'
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

end
