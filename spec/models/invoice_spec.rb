require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
    it { should have_many(:discounts).through(:invoice_items) }
  end
  describe "instance methods" do
    it "total_revenue" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)

      expect(@invoice_1.total_revenue).to eq(100)
    end
  end

  describe '.discounted_revenue' do
    before(:each) do
      @customer1= create(:customer)

      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)

      @discount1 = create(:discount, merchant_id: @merchant1.id, quantity_threshold: 10, percentage: 50.0)
      @discount2 = create(:discount, merchant_id: @merchant1.id, quantity_threshold: 5 )
      @discount3 = create(:discount, merchant_id: @merchant1.id, quantity_threshold: 20, percentage: 60.0)
      @discount4 = create(:discount, merchant_id: @merchant2.id, quantity_threshold: 5, percentage: 60.0)

      @item1 = create(:item, unit_price: 10, merchant_id: @merchant1.id)
      @item2 = create(:item, unit_price: 5, merchant_id: @merchant1.id)
      @item3 = create(:item, unit_price: 10, merchant_id: @merchant2.id)

      @invoice1 = create(:invoice, status: 2, customer_id: @customer1.id)
      @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, unit_price: 10, quantity: 10, status: 2)
      @invoice_item2 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item2.id, unit_price: 5, quantity: 5, status: 2)
      @invoice_item3 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item3.id, unit_price: 5, quantity: 5, status: 2)
    end

    it '.total_revenue_for_merchant - provides total revenue without discount per merchant' do
      expect(@invoice1.total_revenue).to eq(150)
      expect(@invoice1.total_revenue_for_merchant(@merchant1)).to eq(125)
    end

    it '.discount_off - provides amount subtracted per merchant' do
      expect(@invoice1.discount_off_per_merchant(@merchant1)).to eq(55)
    end

    it '.discounted_revenue_for_merchant - provides discounted revenue if discount applies' do
      expect(@invoice1.discounted_revenue_for_merchant(@merchant1)).to eq(70)
    end

    it '.discount_off_whole_invoice - provides amount subtracted of whole invoice' do
      expect(@invoice1.discount_off_whole_invoice).to eq(70)
    end

    it '.discounted_revenue_whole_invoice - gives revenue of entire invoice w/ discounts' do
      expect(@invoice1.discounted_revenue_whole_invoice).to eq(80)
    end
  end
end
