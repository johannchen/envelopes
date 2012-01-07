class TransactionsController < ApplicationController
  load_and_authorize_resource

  def index
    @transactions = current_user.transactions.page(params[:page]).per(10)
    @transaction = Transaction.new
  end

  def new
  end

  def create
    params[:transaction][:amount] = "-" + params[:transaction][:amount] unless params[:income].to_i == 1
    @transaction = current_user.transactions.build(params[:transaction])
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
    # Heroku has tempfile class, which can access for the duration of the request
    csv_text = IO.read(params[:transaction_file].tempfile.path)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      t = row.to_hash 
      t["account_id"] = params[:account_id]
      #TODO: check if creation fail
      Transaction.create!(t.symbolize_keys)
    end

    redirect_to transactions_path, notice: "Successfully uploaded transactions!"
  end
end
