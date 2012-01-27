class TransfersController < ApplicationController
  #TODO fix authorizaton
  authorize_resource :class => false
  def new
    @envelopes = current_user.envelopes.order("name")
  end

  def create
    from = current_user.transactions.new(:date => params[:transfer_date], :envelope_id => params[:from], :amount => "-#{params[:amount]}", :name => params[:name], :allocated => true)
    to = current_user.transactions.new(:date => params[:transfer_date], :envelope_id => params[:to], :amount => params[:amount], :name => params[:name], :allocated => true)
    if from.save and to.save
      redirect_to envelopes_path, notice: "Successfully transfer money!"
    else
      render 'new', notice: "Sorry, it fails to transfer money!"
    end
  end

end
