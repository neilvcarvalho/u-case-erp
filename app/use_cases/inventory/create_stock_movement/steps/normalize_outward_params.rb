module Inventory
  module CreateStockMovement
    module Steps
      class NormalizeOutwardParams < Micro::Case
        attributes :product, :params

        def call!
          stock_movement_params = params.require(:stock_movement).permit(:quantity, :total_value_in_cents)

          stock_movement_params[:quantity] = Float(stock_movement_params[:quantity]) * -1
          Success result: { product: product, params: stock_movement_params }
        rescue ArgumentError
          stock_movement_params[:quantity] = nil
          Success result: { product: product, params: stock_movement_params }
        end
      end
    end
  end
end