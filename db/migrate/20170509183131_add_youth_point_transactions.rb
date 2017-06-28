class AddYouthPointTransactions < ActiveRecord::Migration
  def change
    create_table :youth_point_transactions do |t|
      t.integer :points
      t.references :worker
      t.text :description
    end
  end
end
