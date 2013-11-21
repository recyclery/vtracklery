class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :first_at
      t.datetime :last_at
      t.integer :wday
      t.integer :s_hr
      t.integer :s_min
      t.integer :e_hr
      t.integer :e_min

      t.timestamps
    end
  end
end
