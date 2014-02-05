require 'spec_helper'

describe Bank do
  let!(:user) { FactoryGirl.create :user }

  before do
    @bank = user.banks.build(name: "Security Test Bank")
  end

  subject { @bank }
  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }


  describe "when it does not have a name" do
    before { @bank.name = "" }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @bank.name = 'a' * 51 }
    it { should_not be_valid }
  end
end
