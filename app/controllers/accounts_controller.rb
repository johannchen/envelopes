class AccountsController < ApplicationController
  load_and_authorize_resource

  def index
    @accounts = Account.all
  end

  def new
  end

  def create
    if @account.save
      redirect_to accounts_path, notice: "Successfully added account!"
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end
end
