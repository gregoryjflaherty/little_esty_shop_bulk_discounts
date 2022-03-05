class DiscountsController < ApplicationController
  before_action :set_merchant, only: [:index, :show, :create]
  before_action :set_discount, only: [:show]
  before_action :set_holidays, only: [:index]

  def index
    @discounts = @merchant.discounts
  end

  def new
    @discount = Discount.new
  end

  def create
    @discount = @merchant.discounts.create!(discount_params)
    if @discount.save
      flash[:notice] = "#{@discount.name} Has Been Created!"
      redirect_to merchant_discounts_path(@merchant.id)
    else
      flash[:notice] = "#{@discount.errors.messages}"
      render :new
    end
  end

  def show

  end

  private

  def discount_params
    params.require(:discount).permit(:name, :quantity_threshold, :percentage)
  end

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
