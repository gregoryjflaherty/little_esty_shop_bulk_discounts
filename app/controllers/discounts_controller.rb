class DiscountsController < ApplicationController
  before_action :set_merchant
  before_action :set_discount, only: [:show, :destroy, :update, :edit]
  before_action :set_holidays, only: [:index]

  def index
    @discounts = @merchant.discounts
  end

  def new
    @discount = Discount.new
  end

  def create
    @discount = @merchant.discounts.create(discount_params)
    if @discount.save
      flash[:notice] = "#{@discount.name} Has Been Created!"
      redirect_to merchant_discounts_path(@merchant.id)
    else
      flash[:alert] = "Error: #{error_message(@discount.errors)}"
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @discount.update(discount_params)
      flash[:notice] = "#{@discount.name} Has Been Updated!"
      redirect_to merchant_discount_path(@merchant, @discount)
    else
      flash[:alert] = "Error: #{error_message(@discount.errors)}"
      redirect_to edit_merchant_discount_path(@merchant, @discount)
    end
  end

  def destroy
    @discount.destroy!
    flash[:notice] = "#{@discount.name} Has Been Deleted!"
    redirect_to merchant_discounts_path(@merchant.id)
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
