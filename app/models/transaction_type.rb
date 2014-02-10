class TransactionType < OpenStruct
  TYPES = {
    1 => { id: 1, name: 'Debit'  },
    2 => { id: 2, name: 'Credit' },
    3 => { id: 3, name: 'Check'  },
    4 => { id: 4, name: 'Income' }
  }

  def self.all
    TYPES.keys.map { |id| new(TYPES[id])}
  end
end
