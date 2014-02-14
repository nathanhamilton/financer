class TransactionType < OpenStruct
  TYPES = {
    1 => { id: 1, name: 'Debit', negative?: true },
    2 => { id: 2, name: 'Credit', negative?: true },
    3 => { id: 3, name: 'Check', negative?: true },
    4 => { id: 4, name: 'Income' }
  }

  def self.all
    TYPES.keys.map { |id| new(TYPES[id])}
  end

  def self.find_by_name(str)
    id = TYPES.keys.detect { |id| TYPES[id][:name] == str }
    new(TYPES[id]) if id
  end
end
