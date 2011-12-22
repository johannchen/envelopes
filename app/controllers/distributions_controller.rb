class DistributionsController < ApplicationController
  before_filter :allocate_envelopes, :only => :create

  def new
    @distribution = Distribution.new
    @envelopes = Envelope.all
  end

  def create
    @distribution = Distribution.new(params[:distribution])
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
      Transaction.create(:envelope_name => key, :amount => value, :allocated => true) unless value.blank?
    end
  end
end
