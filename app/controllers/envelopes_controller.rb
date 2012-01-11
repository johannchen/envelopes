class EnvelopesController < ApplicationController
  load_and_authorize_resource
  respond_to :json, :only => :update

  def index
    @monthly_envelopes = current_user.envelopes.where(:monthly => :true)
    @monthly_total_budget = @monthly_envelopes.sum("budget")
    @annual_envelopes = current_user.envelopes.where(:monthly => :false)
    @annual_total_budget = @annual_envelopes.sum("budget")
    @envelope = Envelope.new
    @recent_transactions = current_user.recent_transactions 
    @distribution = Distribution.new
    @envelopes = current_user.envelopes 
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
    @envelope.update_attributes(params[:envelope])
    respond_with_bip(@envelope)
  end

  def destroy
  end

end
