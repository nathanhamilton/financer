require 'rails_helper'

describe Envelope, type: :model do
  let!(:user) { FactoryGirl.create :user }
  let!(:envelope) { FactoryGirl.create :envelope }

  subject { envelope }

  describe 'associations' do
    it { is_expected.to respond_to :category }
    it { is_expected.to respond_to :total }
    it { is_expected.to respond_to :transaction }
    it { is_expected.to have_many :transactions }
    it { is_expected.to belong_to :user }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :category }
    it { is_expected.to validate_presence_of :user_id }
  end

  it { is_expected.to be_valid }
end
