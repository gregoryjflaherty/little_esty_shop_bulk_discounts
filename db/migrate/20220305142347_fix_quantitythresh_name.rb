class FixQuantitythreshName < ActiveRecord::Migration[5.2]
  def change
    rename_column :discounts, :quantity_thresh, :quantity_threshold
  end
end
