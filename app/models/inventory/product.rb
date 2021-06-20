class Inventory::Product < ApplicationRecord
  belongs_to :company

  validates :available_quantity, numericality: { minimum: 0 }
  validates :name, presence: true
  validates :quantity, numericality: { minimum: 0 }
  validates :sku, presence: true, uniqueness: { scope: :company_id }
end
