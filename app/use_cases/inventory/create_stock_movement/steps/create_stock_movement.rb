# The CreateStockMovement class is responsible for creating a stock movement, inward or outward.
#
# This class **must not** be used outside the Inventory::CreateStockMovement module.

module Inventory
  module CreateStockMovement
    module Steps
      class CreateStockMovement < Micro::Case
        attributes :product, :params

        def call!
          stock_movement = product.stock_movements.create!(params)

          Success result: { product: product, stock_movement: stock_movement }
        end
      end
    end
  end
end
