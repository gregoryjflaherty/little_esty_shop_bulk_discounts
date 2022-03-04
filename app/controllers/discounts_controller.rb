class DiscountsController < ApplicationController
  before_action :set_merchant, only: [:index, :show]
  before_action :set_discount, only: [:show]
  before_action :set_holidays, only: [:index]

  def index
    @discounts = @merchant.discounts
  end

  def show

  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def set_discount
    @discount = Discount.find(params[:id])
  end

  def set_holidays
    @holidays = HolidayService.holiday_info
  end
end
