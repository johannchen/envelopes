class DistributionsController < ApplicationController
  load_and_authorize_resource

  before_filter :allocate_envelopes, :only => :create

  def new
    @monthly_envelopes = current_user.envelopes.active.monthly.order("name") 
    @annual_envelopes = current_user.envelopes.active.annual.order("name") 
    @unallocated_amount = current_user.unallocated_amount.to_f
    @total_refill_amount = current_user.total_refill_amount.round(2)
  end

  def create
    if @distribution.save
      redirect_to envelopes_path, notice: "Successfully distributed money!"
    else
      render 'new'
    end
  end

  private
  def allocate_envelopes
    transactions = params[:transactions]
    transactions.each do |key, value|
      current_user.transactions.create(:envelope_name => key, :amount => value, :allocated => true, :name => params[:distribution][:name], :date => params[:distribution][:date] ) unless value.blank? or value.to_f == 0
    end
  end
end
