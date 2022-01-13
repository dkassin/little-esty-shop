class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :bulk_discount_items
  has_many  :items, through: :merchant
  validates :discount, presence: true
  validates :quantity_threshold, presence: true
end
