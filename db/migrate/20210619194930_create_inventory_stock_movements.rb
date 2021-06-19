class CreateInventoryStockMovements < ActiveRecord::Migration[6.1]
  def change
    create_table :inventory_stock_movements do |t|
      t.references :inventory_product, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.decimal :quantity, null: false, default: 0.0
      t.integer :total_value_in_cents, null: false, default: 0

      t.timestamps
    end
  end
end
