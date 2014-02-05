class AddDefaultToEnvelopes < ActiveRecord::Migration
  def up
    change_column :envelopes, :deleted, :boolean, default: false
  end

  def down
    change_column :envelopes, :deleted, :boolean
  end
end
