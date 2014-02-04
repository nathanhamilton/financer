class AddUserIdToBanks < ActiveRecord::Migration
  def up
    add_column :banks, :user_id, :integer
  end

  def down
    remove_column :banks, :user_id
  end
end
