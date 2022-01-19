class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :transactions, through: :invoice
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant
  validates :quantity, :unit_price, :status, presence: true
  enum status: { pending: 0, packaged: 1, shipped: 2 }

  def best_discount
    bulk_discounts.order(discount: :desc)
                  .where('quantity_threshold <= ?', self.quantity)
                  .first
  end
end
