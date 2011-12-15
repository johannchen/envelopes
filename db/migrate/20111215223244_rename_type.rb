class RenameType < ActiveRecord::Migration
  def change 
    remove_column :transactions, :type
    add_column :transactions, :income, :boolean, :default => :false
  end
end
