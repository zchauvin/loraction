class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :contract_id
      t.integer :value

      t.timestamps
    end
  end
end
