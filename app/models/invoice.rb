class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
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
    merchant_filter(merchant).sum {|i_item| i_item.discounted_rev}
  end

  def merchant_filter(merchant)
    invoice_items.joins(:merchant).where(merchants: {id: merchant.id})
  end

  def total_rev_by_merchant(merchant)
    merchant_filter(merchant).sum("invoice_items.unit_price * quantity")
  end

  def amount_discount_rev_filtered(merchant)
    merchant_filter(merchant).joins(:bulk_discounts)
                             .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
                             .select('invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity * (bulk_discounts.discount/100)) as best_discount_amount')
                             .group('invoice_items.id')
                             .sum(&:best_discount_amount)
  end


end
