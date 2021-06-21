# The Company class is responsible for the persistence of company data.

class Company < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :inventory_products, class_name: "Inventory::Product", inverse_of: :company, dependent: :destroy
  has_many :inventory_stock_movements, class_name: "Inventory::StockMovement", inverse_of: :company, dependent: :destroy
end
