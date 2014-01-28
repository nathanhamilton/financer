require 'spec_helper'

describe User do

  before { @user = User.new( name: "Foobar", email: "test@example.com",
                             password: "876asdf", password_confirmation: "876asdf")}

  subject { @user }

  it { should respond_to :name }
  it { should respond_to :email }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = "" }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when the email format is invalid" do
    it "should not be valid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+bas.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end
end
