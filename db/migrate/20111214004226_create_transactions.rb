class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.date :date
      t.string :description
      t.decimal :amount
      t.string :type
      t.integer :user_id

      t.timestamps
    end
  end
end
