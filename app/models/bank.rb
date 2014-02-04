class Bank < ActiveRecord::Base
  belongs_to :user
  has_many :envelopes, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
end
