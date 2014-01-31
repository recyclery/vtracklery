class CreateVtrack < ActiveRecord::Migration
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

    create_table :statuses do |t|
      t.string :name

      t.timestamps
    end
  
    create_table :work_statuses do |t|
      t.string :name

      t.timestamps
    end
  
    create_table :workers do |t|
      t.string :name
      t.string :image
      t.boolean :in_shop, default: false
      t.string :email
      t.string :phone
      t.references :status, index: true,      default: 1
      t.references :work_status, index: true, default: 1
      t.boolean :public_email,   default: false

      t.timestamps
    end
  
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
