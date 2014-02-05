class CreateEnvelopes < ActiveRecord::Migration
  def change
    create_table :envelopes do |t|
      t.integer :bank_id
      t.string :category
      t.boolean :deleted

      t.timestamps
    end
  end
end
