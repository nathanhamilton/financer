class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :envelope

  validates :name, presence: true, length: { maximum: 50 }
  validates_presence_of :transaction_type, :date, :amount, :user_id, :envelope_id
end
