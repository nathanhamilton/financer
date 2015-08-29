class RemoveBankIdFromEnvelopes < ActiveRecord::Migration
  def up
    remove_column :envelopes, :bank_id
  end

  def down
    add_column :envelopes, :bank_id, :integer
  end
end
