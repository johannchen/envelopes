class EnvelopesController < ApplicationController
  load_and_authorize_resource
  respond_to :json, :only => :update

  def index
    @monthly_envelopes = current_user.envelopes.where(:monthly => :true).order("name")
    @monthly_total_budget = @monthly_envelopes.sum("budget")
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

  def annual
    @annual_envelopes = current_user.envelopes.where(:monthly => :false).order("name")
    @annual_total_budget = @annual_envelopes.sum("budget")
    @unallocated_amount = current_user.unallocated_amount.to_f
  end
end
