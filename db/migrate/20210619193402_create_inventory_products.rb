class CreateInventoryProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :inventory_products do |t|
      t.string :sku, null: false
      t.string :name, null: false
      t.text :description
      t.references :company, null: false, foreign_key: true
      t.decimal :quantity, null: false, default: 0.0
      t.decimal :available_quantity, null: false, default: 0.0

      t.index [:company_id, :sku], unique: true

      t.timestamps
    end
  end
end
