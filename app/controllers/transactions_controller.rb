class TransactionsController < ApplicationController
  load_and_authorize_resource

  def index
    @transactions = current_user.transactions.page(params[:page]).per(10)
    @transaction = Transaction.new
  end

  def new
  end

  def create
    if params[:income].to_i == 1
      params[:transaction].delete(:envelope_id) 
    else 
      params[:transaction][:amount] = "-" + params[:transaction][:amount] 
    end
    @transaction = current_user.transactions.build(params[:transaction])
    if @transaction.save
      redirect_to transactions_path, notice: "Successfully recorded expense!"
    else
      render 'new'
    end
  end

  def update
    @transaction.update_attributes(params[:transaction])
    respond_to do |format|
      format.json { respond_with_bip(@transaction) }
    end
  end

  def destroy
    @transaction.destroy
    redirect_to transactions_url
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
