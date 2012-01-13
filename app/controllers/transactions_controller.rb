class TransactionsController < ApplicationController
  load_and_authorize_resource

  def index
    @transactions = current_user.transactions.unallocated.page(params[:page]).order('date DESC')
    @transaction = Transaction.new
  end

  def new
  end

  def create
    if params[:income].to_i == 1
      params[:transaction].delete(:envelope_id) 
      msg = "Successfully recorded income!"
    else 
      params[:transaction][:amount] = "-" + params[:transaction][:amount] 
      msg = "Successfully recorded expense!"
    end
    @transaction = current_user.transactions.build(params[:transaction])
    if @transaction.save
      redirect_to transactions_path, notice: msg
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
      t["date"] = Date.strptime(t["date"], "%m/%d/%Y").to_s
      #TODO: check if creation fail
      current_user.transactions.create!(t.symbolize_keys)
    end

    redirect_to transactions_path, notice: "Successfully uploaded transactions!"
  end
end
