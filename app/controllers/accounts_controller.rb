class AccountsController < ApplicationController
  load_and_authorize_resource

  def index
    @accounts = current_user.accounts.order("name")
  end

  def new
  end

  def create
    @account = current_user.accounts.build(params[:account])
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
