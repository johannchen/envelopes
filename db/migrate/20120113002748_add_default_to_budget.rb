class AddDefaultToBudget < ActiveRecord::Migration
  def change
    change_column_default :envelopes, :budget, 0.0
  end
end
