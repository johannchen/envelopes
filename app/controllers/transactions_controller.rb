class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.page(params[:page]).per(10)
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(params[:transaction])
    if @transaction.save
      redirect_to transactions_path, notice: "Successfully recorded expense!"
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

end
