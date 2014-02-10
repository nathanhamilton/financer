class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :name
      t.string :type
      t.date :date

      t.timestamps
    end
  end
end
