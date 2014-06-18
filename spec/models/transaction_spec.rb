require 'rails_helper'

describe Transaction, type: :model do
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

  it { is_expected.to respond_to :user }
  it { is_expected.to respond_to :envelope }
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :transaction_type }
  it { is_expected.to respond_to :date }
  it { is_expected.to respond_to :amount }
  it { is_expected.to respond_to :user_id }
  it { is_expected.to respond_to :envelope_id }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :transaction_type }
  it { is_expected.to validate_presence_of :date }
  it { is_expected.to validate_presence_of :amount }
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :envelope_id }
  it { is_expected.to belong_to :envelope }
  it { is_expected.to belong_to :user }

  describe '#envelope' do
    subject { super().envelope }
    it { is_expected.to eq(envelope) }
  end

  it { is_expected.to be_valid }

  describe "when name is blank" do
    before { @transaction.name = ''}
    it { is_expected.not_to be_valid }
  end

  describe "when name is too long" do
    before { @transaction.name = 'a' * 51}
    it { is_expected.not_to be_valid }
  end

  describe "when amount is blank" do
    before { @transaction.amount = nil }
    it { is_expected.not_to be_valid }
  end

  describe "when the date is blank" do
    before { @transaction.date = ''}
    it { is_expected.not_to be_valid }
  end

  describe "when transaction_type is blank" do
    before { @transaction.transaction_type = ''}
    it { is_expected.not_to be_valid }
  end

  describe ".transaction_type_object" do
    before { @transaction.transaction_type_object }

    it "returns the transaction type object" do
      type = TransactionType.find_by_name(@transaction.transaction_type)
      expect(type.name).to eq('Credit')
    end
  end

  describe ".check_transaction_type" do

    context "Debit" do

      before do
        @transaction.transaction_type = "Debit"
        @transaction.check_transaction_type
      end

      it "should prepend - to amount if object.negative? == true" do
        expect(@transaction.amount.to_f).to eq(-400.30)
      end
    end

    context "Credit" do

      before do
        @transaction.transaction_type = "Credit"
        @transaction.check_transaction_type
      end

      it "should prepend - to amount if object.negative? == true" do
        expect(@transaction.amount.to_f).to eq(-400.30)
      end
    end

    context "Check" do

      before do
        @transaction.transaction_type = "Check"
        @transaction.check_transaction_type
      end

      it "should prepend - to amount if object.negative? == true" do
        expect(@transaction.amount.to_f).to eq(-400.30)
      end
    end

    context "Income" do

      before do
        @transaction.transaction_type = "Income"
        @transaction.check_transaction_type
      end

      it "should not prepend - to amount if object.negative? == true" do
        expect(@transaction.amount.to_f).not_to eq(-400.30)
      end
    end
  end
end
