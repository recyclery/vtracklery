class AddYouthPointPurchases < ActiveRecord::Migration
  def change
    create_table :youth_point_purchases do |t|
      t.integer :points
      t.references :worker
      t.text :description
    end
  end
end
