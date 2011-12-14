class CreateEnvelops < ActiveRecord::Migration
  def change
    create_table :envelops do |t|
      t.string :name
      t.decimal :budget
      t.boolean :monthly
      t.integer :user_id

      t.timestamps
    end
  end
end
