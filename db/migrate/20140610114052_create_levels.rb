class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :name
      t.string :unit
      t.integer :task_id
      t.integer :contract_id

      t.timestamps
    end
  end
end
