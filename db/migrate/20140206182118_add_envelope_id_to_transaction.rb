class AddEnvelopeIdToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :envelope_id, :integer
  end
end
