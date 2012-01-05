class EnvelopesController < ApplicationController
  load_and_authorize_resource

  def index
    @monthly_envelopes = current_user.envelopes.where(:monthly => :true)
    @monthly_total_budget = @monthly_envelopes.sum("budget")
    @annual_envelopes = current_user.envelopes.where(:monthly => :false)
    @annual_total_budget = @annual_envelopes.sum("budget")
    @envelope = Envelope.new
    @recent_transactions = current_user.recent_transactions 
  end

  def new
  end

  def create
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
