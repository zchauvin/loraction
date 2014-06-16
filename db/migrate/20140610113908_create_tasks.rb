class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :category_id
      t.string :timescale

      t.timestamps
    end
  end
end
