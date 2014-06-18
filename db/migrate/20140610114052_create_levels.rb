class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :name
      t.string :unit
      t.integer :task_id
      t.string :timescale

      t.timestamps
    end
  end
end
