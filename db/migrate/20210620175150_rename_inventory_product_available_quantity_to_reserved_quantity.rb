class RenameInventoryProductAvailableQuantityToReservedQuantity < ActiveRecord::Migration[6.1]
  def change
    rename_column :inventory_products, :available_quantity, :reserved_quantity
  end
end
