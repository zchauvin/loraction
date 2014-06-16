class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.date :finish_date
      # t.integer :timescale
      # t.integer :reduction_goal
      t.integer :user_id
      t.integer :task_id

      t.timestamps
    end
  end
end
