require 'rails_helper'

RSpec.describe 'Merchant Dashboard Links to Discount Index' do
  describe 'User Story 1' do
    before(:each) do
      @merchant1 = create(:merchant)

      @discount1 = create(:discount, merchant_id: @merchant1.id )
      @discount2 = create(:discount, merchant_id: @merchant1.id )
      @discount3 = create(:discount, merchant_id: @merchant1.id )
      @discount4 = create(:discount, merchant_id: @merchant1.id )
    end

    it 'As a merchant, I visit my dashboard and see a link to all my discounts' do
      visit merchant_dashboard_index_path(@merchant1)
      expect(current_path).to eq(merchant_dashboard_index_path(@merchant1))

      expect(page).to have_link('Discounts')

      click_on "Discounts"
      expect(current_path).to eq(merchant_discounts_path(@merchant1))
      end

    it 'I am taken to bulk discounts index and see see all discounts with attributes' do
      visit merchant_discounts_path(@merchant1)
      expect(current_path).to eq(merchant_discounts_path(@merchant1))

      within 'div.discount_links' do
        expect(page).to have_link(@discount1.name)
        expect(page).to have_link(@discount2.name)
        expect(page).to have_link(@discount3.name)
        expect(page).to have_link(@discount4.name)
      end
    end

    it 'I am taken to bulk discounts index and see see all discounts with attributes' do
      visit merchant_discounts_path(@merchant1)
      expect(current_path).to eq(merchant_discounts_path(@merchant1))

      within 'div.discount_links' do
        click_on @discount1.name
      end
      expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))

      within 'div.title' do
        expect(page).to have_content(@discount1.name)
      end
    end
  end
end
