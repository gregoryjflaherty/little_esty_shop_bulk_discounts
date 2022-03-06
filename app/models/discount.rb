class Discount < ApplicationRecord
  validates_presence_of :name,
                        :merchant_id,
                        :quantity_threshold,
                        :percentage
  belongs_to :merchant
end
