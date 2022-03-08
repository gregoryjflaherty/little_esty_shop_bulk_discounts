class Discount < ApplicationRecord
  validates_presence_of :name,
                        :merchant_id,
                        :quantity_threshold,
                        :percentage
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items 
end
