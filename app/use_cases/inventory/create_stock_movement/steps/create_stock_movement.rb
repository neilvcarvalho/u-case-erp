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
