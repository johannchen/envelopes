class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.page(params[:page]).per(10)
  end

  def new
    @transaction = Transaction.new
  end

  def create
    params[:transaction][:amount] = "-" + params[:transaction][:amount] if params[:income]
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

  def upload
    require 'csv'
    csv_text = IO.read(params[:file].tempfile.path)
    csv = CSV.parse(csv_text, :headers => true)
    #csv.each do |row|
    #end
  end
end
