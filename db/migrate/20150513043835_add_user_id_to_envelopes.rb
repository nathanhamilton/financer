class AddUserIdToEnvelopes < ActiveRecord::Migration
  def change
    add_column :envelopes, :user_id, :integer
  end
end
