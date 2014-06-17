class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.text :description
      t.integer :level_id

      t.timestamps
    end
  end
end
