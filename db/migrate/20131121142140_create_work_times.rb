class CreateWorkTimes < ActiveRecord::Migration
  def change
    create_table :work_times do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.references :worker, index: true
      t.references :status, index: true
      t.references :work_status, index: true

      t.timestamps
    end
  end
end
