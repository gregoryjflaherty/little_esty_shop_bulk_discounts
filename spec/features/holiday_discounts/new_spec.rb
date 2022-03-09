require 'rails_helper'

RSpec.describe 'Create Holiday Discount' do
  before(:each) do
    @merchant1 = create(:merchant)
    @holiday = HolidayService.holiday_info[0]
  end

  describe 'Extension 1 - Create Holiday Discount' do
    it 'has a button next to holiday - clicking this button takes me to a create discount form' do
      visit merchant_discounts_path(@merchant1)
      expect(current_path).to eq(merchant_discounts_path(@merchant1))

      within 'div.holiday_0' do
        expect(page).to have_button("Create #{@holiday.name} Discount")
        click_on "Create #{@holiday.name} Discount"
      end
      expect(current_path).to eq(new_merchant_holiday_discount_path(@merchant1, @holiday.name))
    end

    it 'pre-populates with holiday name, percentage and quantity quantity_threshold' do
      visit merchant_discounts_path(@merchant1)
      expect(current_path).to eq(merchant_discounts_path(@merchant1))

      within 'div.holiday_0' do
        click_on "Create #{@holiday.name} Discount"
        expect(current_path).to eq(new_merchant_holiday_discount_path(@merchant1, @holiday.name))
      end

      expect(page).to have_field('discount_name', with: @holiday.name)
      expect(page).to have_field('discount_quantity_threshold', with: 2)
      expect(page).to have_field('discount_percentage', with: 30.0)
    end

    it 'Sumbitting new discount saves the discount to discount index' do
      visit "/merchant/#{@merchant1.id}/discounts"
      expect(current_path).to eq("/merchant/#{@merchant1.id}/discounts")

      within 'div.holiday_0' do
        click_on "Create #{@holiday.name} Discount"
        expect(current_path).to eq(new_merchant_holiday_discount_path(@merchant1, @holiday.name))
      end

      click_on "Create New Discount"
      expect(current_path).to eq(merchant_discounts_path(@merchant1))

      within 'div.discounts' do
        expect(page).to have_link(@holiday.name)
      end
    end
  end
end
