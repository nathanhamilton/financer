class AddPolymorphicRelationshipToTransactions < ActiveRecord::Migration
  def up
    change_table :transactions do |t|
      t.references :institutionable, polymorphic: true
    end
  end

  def down
    change_table :transactions do |t|
      t.remove_references :institutionable, polymorphic: true
    end
  end
end
