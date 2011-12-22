class CreateDistributions < ActiveRecord::Migration
  def change
    create_table :distributions do |t|
      t.string :name
      t.date :date
      t.decimal :amount
      t.string :details
      t.boolean :monthly
      t.integer :transaction_id
      t.timestamps
    end
  end
end
