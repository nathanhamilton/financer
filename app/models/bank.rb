class Bank < ActiveRecord::Base
  belongs_to :user
  has_many :envelopes, dependent: :destroy
  has_many :transactions, through: :envelopes

  validates :name, presence: true, length: { maximum: 50 }
end
