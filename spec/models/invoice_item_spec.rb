require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should have_many(:discounts).through(:item) }
  end

  describe "class methods" do
    before(:each) do
      @m1 = Merchant.create!(name: 'Merchant 1')
      @c1 = Customer.create!(first_name: 'Bilbo', last_name: 'Baggins')
      @c2 = Customer.create!(first_name: 'Frodo', last_name: 'Baggins')
      @c3 = Customer.create!(first_name: 'Samwise', last_name: 'Gamgee')
      @c4 = Customer.create!(first_name: 'Aragorn', last_name: 'Elessar')
      @c5 = Customer.create!(first_name: 'Arwen', last_name: 'Undomiel')
      @c6 = Customer.create!(first_name: 'Legolas', last_name: 'Greenleaf')
      @item_1 = Item.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10, merchant_id: @m1.id)
      @item_2 = Item.create!(name: 'Conditioner', description: 'This makes your hair shiny', unit_price: 8, merchant_id: @m1.id)
      @item_3 = Item.create!(name: 'Brush', description: 'This takes out tangles', unit_price: 5, merchant_id: @m1.id)
      @i1 = Invoice.create!(customer_id: @c1.id, status: 2)
      @i2 = Invoice.create!(customer_id: @c1.id, status: 2)
      @i3 = Invoice.create!(customer_id: @c2.id, status: 2)
      @i4 = Invoice.create!(customer_id: @c3.id, status: 2)
      @i5 = Invoice.create!(customer_id: @c4.id, status: 2)
      @ii_1 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
      @ii_2 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
      @ii_3 = InvoiceItem.create!(invoice_id: @i2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
      @ii_4 = InvoiceItem.create!(invoice_id: @i3.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 1)
    end
    it 'incomplete_invoices' do
      expect(InvoiceItem.incomplete_invoices).to eq([@i1, @i3])
    end
  end

  describe '.instance_methods' do
    before(:each) do
      @customer1= create(:customer)
      @merchant1 = create(:merchant)
      @discount1 = create(:discount, merchant_id: @merchant1.id, quantity_threshold: 10, percentage: 50.0)
      @discount2 = create(:discount, merchant_id: @merchant1.id, quantity_threshold: 5 )
      @discount3 = create(:discount, merchant_id: @merchant1.id, quantity_threshold: 20, percentage: 60.0)
      @item1 = create(:item, unit_price: 10, merchant_id: @merchant1.id)
      @item2 = create(:item, unit_price: 5, merchant_id: @merchant1.id)
      @invoice1 = create(:invoice, status: 2, customer_id: @customer1.id)
      @invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, unit_price: 10, quantity: 10, status: 2)
      @invoice_item2 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item2.id, unit_price: 5, quantity: 5, status: 2)
      @invoice_item3 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item2.id, unit_price: 5, quantity: 2, status: 2)
    end

    it '.best_discount - gives best discount' do
      expect(@invoice_item1.best_discount).to eq(@discount1)
      expect(@invoice_item2.best_discount).to eq(@discount2)
      expect(@invoice_item3.best_discount).to eq(nil)
    end
  end
end
