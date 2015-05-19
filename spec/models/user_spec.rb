require 'rails_helper'

describe User, type: :model do

  before { @user = User.new( name: "Foobar", email: "test@example.com",
                             password: "876asdf", password_confirmation: "876asdf")}

  subject { @user }

  describe 'associations' do
    it { is_expected.to have_many :banks }
    it { is_expected.to have_many :envelopes }
    it { is_expected.to have_many :transactions }
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :email }
    it { is_expected.to respond_to :password_digest }
    it { is_expected.to respond_to :password }
    it { is_expected.to respond_to :password_confirmation }
    it { is_expected.to respond_to :remember_token }
    it { is_expected.to respond_to :authenticate }
    it { is_expected.to respond_to :banks }
    it { is_expected.to respond_to :envelopes }
    it { is_expected.to respond_to :transactions }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
  end

  it { is_expected.to be_valid }

  describe "when name is not present" do
    before { @user.name = "" }
    it { is_expected.not_to be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "" }
    it { is_expected.not_to be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { is_expected.not_to be_valid }
  end

  describe "when the email format is invalid" do
    it "should not be valid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+bas.com]
      addresses.each do |invalid_address|
        @user = User.new(FactoryGirl.attributes_for(User, email: invalid_address))
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Foobar", email: "test@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { is_expected.not_to be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { is_expected.not_to be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { is_expected.to be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { is_expected.to eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { is_expected.not_to eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end
  end

  describe "remember token" do
    before { @user.save }

    describe '#remember_token' do
      subject { super().remember_token }
      it { is_expected.not_to be_blank }
    end
  end
end
