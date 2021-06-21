# The InwardFlow class is responsible for creating an inward stock movement.
#
# This class **may** be used in any module and is part of the Inventory public interface.

module Inventory
  module CreateStockMovement
    class InwardFlow < Micro::Case
      attributes :product, :params

      validates :product, kind: Inventory::Product
      validates :params, kind: ActionController::Parameters

      def call!
        product.with_lock do
          call(Steps::NormalizeInwardParams)
            .then(Steps::CreateStockMovement)
        end
      rescue ActiveRecord::RecordInvalid => e
        Failure :invalid_stock_movement, result: { errors: e.record.errors.full_messages }
      end
    end
  end
end
