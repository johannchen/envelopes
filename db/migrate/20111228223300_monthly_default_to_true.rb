class MonthlyDefaultToTrue < ActiveRecord::Migration
  def change 
    change_column_default :envelopes, :monthly, true
  end
end
