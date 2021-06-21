# The NormalizeOutwardParams class is responsible for changing the quantity of an outward stock movement to a negative
# value.
#
# This class **must not** be used outside the Inventory::CreateStockMovement module.

module Inventory
  module CreateStockMovement
    module Steps
      class NormalizeInwardParams < Micro::Case
        attributes :product, :params

        def call!
          stock_movement_params = params.require(:stock_movement).permit(:quantity, :total_value_in_cents)

          stock_movement_params[:quantity] = Float(stock_movement_params[:quantity]).abs
          Success result: { product: product, params: stock_movement_params }
        rescue ArgumentError
          Success result: { product: product, params: stock_movement_params }
        end
      end
    end
  end
end
