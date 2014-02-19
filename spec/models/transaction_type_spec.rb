require 'spec_helper'

describe TransactionType do
  it "should return all transaction types" do
    types = TransactionType.all
    expect(types.map(&:id)).to eq [1,2,3,4]
    expect(types.map(&:name)).to eq %w[Debit Credit Check Income]
    expect(types.map(&:negative?)).to eq [true, true, true, false]
  end

  it "should fail and give me a decent message" do
    expect { TransactionType.find_by_name("Fake Income").name }.to raise_error NoMethodError, /no_transaction_type_value/i
  end

  it "should expect to return the correct type" do
    type = TransactionType.find_by_name("Debit")
    expect(type.negative?).to be_true
  end
end
