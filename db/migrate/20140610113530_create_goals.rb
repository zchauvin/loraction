class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :initial
      t.integer :target
      t.integer :contract_id
      t.integer :level_id

      t.timestamps
    end
  end
end
