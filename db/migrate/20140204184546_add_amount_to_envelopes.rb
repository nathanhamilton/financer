class AddAmountToEnvelopes < ActiveRecord::Migration
  def up
    add_column :envelopes, :total, :decimal, precision: 11, scale: 2
  end


  def down
    add_column :envelopes, :total, :decimal
  end
end
