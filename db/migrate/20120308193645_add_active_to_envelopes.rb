class AddActiveToEnvelopes < ActiveRecord::Migration
  def change
    add_column :envelopes, :active, :boolean, :default => true
  end
end
