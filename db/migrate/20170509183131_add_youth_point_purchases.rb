class AddYouthPointPurchases < ActiveRecord::Migration
  def change
    create_table :youth_point_purchases do |t|
      t.decimal :points, precision: 10, scale: 2
      t.references :worker
      t.text :description
    end
  end
end
