class AddAmountToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :amount, :decimal, precision: 11, scale: 2
  end
end
