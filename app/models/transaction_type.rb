class TransactionType < OpenStruct

  class TransactionTypeValue
    def initialize(id, name, negative: true)
      @id = id
      @name = name
      @negative = negative
    end

    def negative?
      !!@negative
    end
  end

  TYPES = [
    TransactionTypeValue.new(1, 'Debit'),
    TransactionTypeValue.new(2, 'Credit'),
    TransactionTypeValue.new(3, 'Check'),
    TransactionTypeValue.new(4, 'Income', negative: false)
  ]

  def self.all
    TYPES
  end

  def self.find_by_name(str)
    all.detect { |val| val.name == str } || :no_transaction_type_value
  end
end
