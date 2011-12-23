class TransfersController < ApplicationController
  def new
  end

  def create
    from = Transaction.new(:date => params[:date], :envelope_id => params[:from], :amount => "-#{params[:amount]}", :description => params[:description])
    to = Transaction.new(:date => params[:date], :envelope_id => params[:to], :amount => params[:amount], :description => params[:description])
    if from.save and to.save
      redirect_to envelopes_path, notice: "Successfully transfer money!"
    else
      render 'new'
    end
  end

end
