class RenameTableEnvelop < ActiveRecord::Migration
  def change
    rename_table :envelops, :envelopes
    add_column :transactions, :envelope_id, :integer 
    add_column :transactions, :account_id, :integer 
  end
end
