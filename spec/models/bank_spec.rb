require 'spec_helper'

describe Bank, type: :model do
  let!(:user) { FactoryGirl.create :user }

  before do
    @bank = user.banks.build(name: "Security Test Bank")
  end

  subject { @bank }
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :user_id }
  it { is_expected.to respond_to :user }
  it { is_expected.to respond_to :transaction }
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :envelopes }
  it { is_expected.to have_many(:transactions).through(:envelopes) }

  describe '#user' do
    subject { super().user }
    it { is_expected.to eq(user) }
  end

  it { is_expected.to be_valid }


  describe "when it does not have a name" do
    before { @bank.name = "" }
    it { is_expected.not_to be_valid }
  end

  describe "when name is too long" do
    before { @bank.name = 'a' * 51 }
    it { is_expected.not_to be_valid }
  end
end
