class DropDiscountsTablesTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :discounts_tables
  end
end
