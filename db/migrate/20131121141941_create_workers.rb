class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.string :name
      t.string :image
      t.boolean :in_shop
      t.string :email
      t.string :phone
      t.references :status, index: true
      t.references :work_status, index: true
      t.boolean :public_email

      t.timestamps
    end
  end
end
