require 'spec_helper'

describe Transaction do
  let!(:user) { FactoryGirl.create :user }
  let!(:bank) { FactoryGirl.create :bank }
  let!(:envelope) { FactoryGirl.create :envelope }

  before do
    attributes = {
      name: 'Transaction',
      transaction_type: "Credit",
      date: "02/07/2014",
      amount: 400.30,
      user_id: user.id
    }

    @transaction = envelope.transactions.build(attributes)
  end

  subject { @transaction }

  it { should respond_to :user }
  it { should respond_to :envelope }
  it { should respond_to :name }
  it { should respond_to :transaction_type }
  it { should respond_to :date }
  it { should respond_to :amount }
  it { should respond_to :user_id }
  it { should respond_to :envelope_id }
  it { should validate_presence_of :name }
  it { should validate_presence_of :transaction_type }
  it { should validate_presence_of :date }
  it { should validate_presence_of :amount }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :envelope_id }
  it { should belong_to :envelope }
  it { should belong_to :user }
  its( :envelope ) { should == envelope }

  it { should be_valid }

  describe "when name is blank" do
    before { @transaction.name = ''}
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @transaction.name = 'a' * 51}
    it { should_not be_valid }
  end

  describe "when amount is blank" do
    before { @transaction.amount = nil }
    it { should_not be_valid }
  end

  describe "when the date is blank" do
    before { @transaction.date = ''}
    it { should_not be_valid }
  end

  describe "when transaction_type is blank" do
    before { @transaction.transaction_type = ''}
    it { should_not be_valid }
  end
end
