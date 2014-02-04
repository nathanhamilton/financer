class AddIndexToBanks < ActiveRecord::Migration
  def up
    add_index :banks, :user_id
  end

  def down
    remove_index :banks, :user_id
  end
end
