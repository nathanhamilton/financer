class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :envelope

  validates :name, presence: true, length: { maximum: 50 }
  validates_presence_of :transaction_type, :date, :amount, :user_id, :envelope_id

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
