require 'spec_helper'

describe Envelope do
  let!(:user) { FactoryGirl.create :user }
  let!(:bank) { FactoryGirl.create :bank }

  before do
    @envelope = user.envelopes.build(category: 'Car', total: 200, bank_id: 1)
  end

  subject { @envelope }

  it { should respond_to :bank }
  it { should belong_to :bank }
  it { should respond_to :category }
  it { should respond_to :total }

  its(:bank) { should == bank }

  it { should be_valid }

  describe "When no category is given" do
    before { @envelope.category = '' }
    it { should_not be_valid }
  end

  describe "When no bank_id is given" do
    before { @envelope.bank_id = nil }
    it { should_not be_valid }
  end

  describe "When no total is given" do
    before { @envelope.total = nil }
    it { should_not be_valid }
  end
end
