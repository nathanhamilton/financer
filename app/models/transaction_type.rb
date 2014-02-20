class TransactionType < OpenStruct

  TransactionTypeValue = Struct.new(:id, :name, :negative?)

  TYPES = [
    TransactionTypeValue.new(1,'Debit', true),
    TransactionTypeValue.new(2,'Credit', true),
    TransactionTypeValue.new(3,'Check', true),
    TransactionTypeValue.new(4,'Income', false)
  ]

  def self.all
    TYPES
  end

  def self.find_by_name(str)
    all.detect { |val| val.name == str } || :no_transaction_type_value
  end
end
