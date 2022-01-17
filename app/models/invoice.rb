class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchant, through: :items
  has_many :bulk_discounts, through: :merchants
  validates :status, presence: true
  enum status: { cancelled: 0, "in progress" => 1, completed: 2, pending: 3 }

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def self.incomplete_invoices
    joins(:invoice_items)
    .where.not(invoice_items: {status: "shipped"})
    .order(created_at: :asc)
    .distinct
  end

  def discount_rev_by_merchant(merchant)

    x = []
    merchant_filter(merchant).find_each do |i_item|
         x << i_item.discounted_rev
      end
    x
    binding.pry
  end

  def merchant_filter(merchant)
    invoice_items.joins(:merchant).where(merchants: {id: merchant.id})
  end

  def total_rev_by_merchant(merchant)
    merchant_filter.sum("unit_rice * qauntity")
  end

end
