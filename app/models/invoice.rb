class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :invoice_items

  enum status: [:cancelled, 'in progress', :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_revenue_for_merchant(merchant)
    invoice_items.joins(:item).where('items.merchant_id = ?', merchant.id)
                 .select('invoice_items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
                 .group('invoice_items.id').sum(&:total_revenue)
  end

  def discount_off_per_merchant(merchant)
    invoice_items.joins(:discounts, :item)
                 .where('invoice_items.quantity >= discounts.quantity_threshold')
                 .where('items.merchant_id = ?', merchant.id)
                 .select('invoice_items.item_id, MAX(invoice_items.quantity * invoice_items.unit_price * discounts.percentage * 0.01)')
                 .group('invoice_items.item_id').sum(&:max)
  end

  def discounted_revenue_for_merchant(merchant)
    total_revenue_for_merchant(merchant) - discount_off_per_merchant(merchant)
  end
end
