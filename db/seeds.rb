
Customer.destroy_all
Merchant.destroy_all
Discount.destroy_all
Item.destroy_all
Invoice.destroy_all
InvoiceItem.destroy_all

@customer1= create(:customer)
@customer2= create(:customer)
@customer3= create(:customer)


@merchant1 = create(:merchant)
@merchant2 = create(:merchant)
@merchant3 = create(:merchant)
@merchant4 = create(:merchant)

@discount1 = create(:discount, merchant_id: @merchant1.id, quantity_threshold: 10, percentage: 50.0)
@discount2 = create(:discount, merchant_id: @merchant1.id, quantity_threshold: 5 )
@discount3 = create(:discount, merchant_id: @merchant1.id, quantity_threshold: 25, percentage: 60.0)
@discount3 = create(:discount, merchant_id: @merchant1.id, quantity_threshold: 20, percentage: 55.0)
@discount3 = create(:discount, merchant_id: @merchant1.id, quantity_threshold: 15, percentage: 30.0)
@discount3 = create(:discount, merchant_id: @merchant2.id, quantity_threshold: 20, percentage: 60.0)
@discount3 = create(:discount, merchant_id: @merchant3.id, quantity_threshold: 10, percentage: 30.0)
@discount3 = create(:discount, merchant_id: @merchant4.id, quantity_threshold: 20, percentage: 60.0)
@discount3 = create(:discount, merchant_id: @merchant2.id, quantity_threshold: 10, percentage: 30.0)
@discount3 = create(:discount, merchant_id: @merchant3.id, quantity_threshold: 20, percentage: 60.0)

@item1 = create(:item, unit_price: 10, merchant_id: @merchant1.id)
@item2 = create(:item, unit_price: 5, merchant_id: @merchant1.id)

@invoice1 = create(:invoice, status: 2, customer_id: @customer1.id)

@invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id, unit_price: 10, quantity: 10, status: 2)
@invoice_item2 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item2.id, unit_price: 5, quantity: 5, status: 2)
@invoice_item3 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item2.id, unit_price: 5, quantity: 2, status: 2)
