class AddBankIdIndexToEnvelopes < ActiveRecord::Migration
  def change
    add_index :envelopes, :bank_id
  end
end
