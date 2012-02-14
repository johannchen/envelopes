class TransactionsController < ApplicationController
  require 'csv'

  load_and_authorize_resource

  def index
    @transaction = Transaction.new

    if params[:envelope].present? and params[:account].present?
      ts = Account.find(params[:account]).transactions.where("envelope_id = #{params[:envelope]}")
    elsif params[:account].present?
      ts = Account.find(params[:account]).transactions
    elsif params[:envelope].present?
      ts = Envelope.find(params[:envelope]).transactions
    else
      ts = current_user.transactions
    end

    ts = filter_by_type(params[:type].to_i, ts) if params[:type].present?

    ts = ts.search(params[:search]) if params[:search].present?

    if params[:start_date].present? and params[:end_date].present?
      ts = ts.period(params[:start_date], params[:end_date])
    end
  
    if params[:format] == "mobile"
      @transactions = ts.months_ago_till_now(2).order('date DESC')
    else
      @transactions = ts.page(params[:page]).order('date DESC')
    end
   
    respond_to do |format|
      format.html
      format.js
      format.mobile 
      format.csv { render text: download(@transactions)}
    end
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

  def new_upload
  end

  def upload
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

  private

  def filter_by_type(type, ts)
    case type
    when 0
      ts.expense
    when 1
      ts.income
    when 2
      current_user.transactions.allocated
    when 3
      current_user.transactions.excluded
    end
  end

  def download(transactions)
    csv_data = CSV.generate do |csv|
      csv << ["date", "amount", "name", "envelope_name", "account_name"]
      transactions.map do |tx|
        csv << [tx.date, tx.amount, tx.name, tx.envelope_name, tx.account_name]
      end
    end
    csv_data
  end
end
