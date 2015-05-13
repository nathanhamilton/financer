# Bank
#
# id:          integer
# name:        string (255)
# created_at:  datetime
# updated_at:  datetime
# user_id:     integer

class Bank < ActiveRecord::Base
  belongs_to :user
  has_many :envelopes, dependent: :destroy
  has_many :transactions, as: :institutionable

  validates :name, presence: true, length: { maximum: 50 }
end
