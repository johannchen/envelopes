class AddExcludedToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :excluded, :boolean, :default => false
  end
end
