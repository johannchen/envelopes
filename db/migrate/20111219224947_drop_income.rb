class DropIncome < ActiveRecord::Migration
  def change
    remove_column :transactions, :income
  end
end
