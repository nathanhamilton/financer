require 'spec_helper'

describe "bank" do
  let(:user) { FactoryGirl.create :user, id: 1 }

  before do
    @bank = user.bank.build(name: 'Holding Bank', user_id: 1)
  end

  subject { @bank }

  it { should respond_to(:user) }

end
