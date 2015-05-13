# Transaction
#
# id:                    integer
# name:                  string (255)
# transaction_type:      string (255)
# date:                  date
# created_at:            datetime
# updated_at:            datetime
# amount:                decimal, precision: 11, scale: 2
# user_id:               integer
# envelope_id:           integer
# institutionable_id:    integer
# institutionable_type:  string (255)

class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :envelope
  belongs_to :institutionable, polymorphic: true

  validates :name, presence: true, length: { maximum: 50 }
  validates_presence_of :transaction_type, :date, :amount, :user_id, :envelope_id, :institutionable_id, :institutionable_type

  before_save :check_transaction_type

  def check_transaction_type
    if transaction_type_object.negative?
      self.amount = -self.amount
    end
  end

  def transaction_type_object
    TransactionType.find_by_name transaction_type
  end
end
