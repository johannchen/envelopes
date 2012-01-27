class AddUserToDistributions < ActiveRecord::Migration
  def change
    add_column :distributions, :user_id, :integer
  end
end
