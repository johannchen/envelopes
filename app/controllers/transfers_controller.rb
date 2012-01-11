class TransfersController < ApplicationController
  skip_authorization_check

  def new
  end

  def create
    from = current_user.transactions.new(:date => params[:transfer_date], :envelope_id => params[:from], :amount => "-#{params[:amount]}", :description => params[:description])
    to = current_user.transactions.new(:date => params[:transfer_date], :envelope_id => params[:to], :amount => params[:amount], :description => params[:description])
    if from.save and to.save
      redirect_to envelopes_path, notice: "Successfully transfer money!"
    else
      render 'new'
    end
  end

end
