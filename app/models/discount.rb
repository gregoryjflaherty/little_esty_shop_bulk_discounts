class Discount < ApplicationRecord
  validates_presence_of :name,
                        :merchant_id,
                        :quantity_thresh,
                        :percentage

  belongs_to :merchant
end
