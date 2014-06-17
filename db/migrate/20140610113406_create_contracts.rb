class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.date :finish_date
      t.integer :initial
      t.integer :target
      t.integer :user_id

      t.timestamps
    end
  end
end
