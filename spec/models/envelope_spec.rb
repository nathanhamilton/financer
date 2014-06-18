require 'spec_helper'

describe Envelope, type: :model do
  let!(:user) { FactoryGirl.create :user }
  let!(:bank) { FactoryGirl.create :bank }

  before do
    @envelope = user.envelopes.build(category: 'Car', total: 200, bank_id: bank.id)
  end

  subject { @envelope }

  it { is_expected.to respond_to :bank }
  it { is_expected.to respond_to :category }
  it { is_expected.to respond_to :total }
  it { is_expected.to respond_to :transaction }
  it { is_expected.to belong_to :bank }
  it { is_expected.to have_many :transactions }

  describe '#bank' do
    subject { super().bank }
    it { is_expected.to eq(bank) }
  end

  it { is_expected.to be_valid }

  describe "When no category is given" do
    before { @envelope.category = '' }
    it { is_expected.not_to be_valid }
  end

  describe "When no bank_id is given" do
    before { @envelope.bank_id = nil }
    it { is_expected.not_to be_valid }
  end
end
