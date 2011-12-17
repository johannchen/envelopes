class AddNote < ActiveRecord::Migration
  def change
    add_column :transactions, :note, :string 
    add_column :accounts, :note, :string 
  end
end
