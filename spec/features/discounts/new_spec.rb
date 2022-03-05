require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount Create' do
  before(:each) do
    @merchant1 = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant1.id )
    @discount2 = create(:discount, merchant_id: @merchant1.id )
    @discount3 = create(:discount, merchant_id: @merchant1.id )
    @discount4 = create(:discount, merchant_id: @merchant1.id )
  end

  describe 'User Story 3 - bulk discounts index has a link to create a new discount' do
    it 'has a link to create a new discount which takes me to a new page' do
      visit merchant_discounts_path(@merchant1)
      expect(current_path).to eq(merchant_discounts_path(@merchant1))

      within "div.create_discount" do
        expect(page).to have_link("Create New Discount")
        click_on "Create New Discount"
        expect(current_path).to eq(new_merchant_discount_path(@merchant1))
      end
    end

    it 'This page has a form where I fill in data and am redirected back to discount index where I see new discount' do
      visit new_merchant_discount_path(@merchant1)
      expect(current_path).to eq(new_merchant_discount_path(@merchant1))

      within 'div.new_discount_form' do
        fill_in('discount_name', with: 'Stark Discount')
        fill_in('discount_quantity_threshold', with: 35)
        fill_in('discount_percentage', with: 45)
        click_on "Create New Discount"
      end
      expect(current_path).to eq(merchant_discounts_path(@merchant1))
      expect(page).to have_content('Stark Discount Has Been Created!')
      expect(page).to have_content('Stark Discount')
    end
  end
end
