class EnvelopesController < ApplicationController
  load_and_authorize_resource

  def index
    @monthly_envelopes = current_user.envelopes.monthly.active.order("name")
    @monthly_total_budget = @monthly_envelopes.sum("budget")
  end

  def new
  end

  def edit
  end

  def create
    if @envelope.save
      redirect_to envelopes_path, notice: 'Sucessfully added envelope!'
    else
      render 'new'
    end
  end

  def update
    if @envelope.update_attributes(params[:envelope])
      respond_to do |format|
        format.json { respond_with_bip(@envelope) }
        format.html { redirect_to envelopes_path, notice: 'Sucessfully updated envelope!' }
      end
    else
      render 'edit'
    end
  end

  def destroy
    if @envelope.transactions.empty?
      @envelope.destroy
      redirect_to envelopes_path, notice: 'The envelope has been reomved successfully'
    else
      redirect_to envelopes_path, notice: "Envelope #{@envelope.name} cannot be removed. You need to clear all transactions associated with envelope before its removal."    
    end 
  end

  def annual
    @annual_envelopes = current_user.envelopes.annual.active.order("name")
    @annual_total_budget = @annual_envelopes.sum("budget")
    @unallocated_amount = current_user.unallocated_amount.to_f
  end
end
