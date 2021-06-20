class AddConfirmedAtToInventoryStockMovement < ActiveRecord::Migration[6.1]
  def change
    add_column :inventory_stock_movements, :confirmed_at, :datetime, index: true
  end
end
