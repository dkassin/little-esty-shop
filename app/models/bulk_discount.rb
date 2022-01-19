class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :bulk_discount_items
  has_many  :items, through: :merchant
  has_many :invoice_items, through: :items
  validates :discount, presence: true
  validates :quantity_threshold, presence: true
  validates_numericality_of :discount, less_than: 100
  validates_numericality_of :quantity_threshold, greater_than_or_equal_to: 1
end
