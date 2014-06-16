class CreateReportFields < ActiveRecord::Migration
  def change
    create_table :report_fields do |t|
      t.float :value
      t.integer :report_id
      t.integer :goal_id

      t.timestamps
    end
  end
end
