class AddAllocatedToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :allocated, :boolean, :default => false
  end
end
