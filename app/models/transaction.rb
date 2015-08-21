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

  validates :name, presence: true, length: { maximum: 100 }
  validates_presence_of :transaction_type, :date, :amount, :user_id,
                        :envelope_id, :institutionable_id, :institutionable_type

  before_create :check_transaction_type
  # after_validation :modify_date

  def check_transaction_type
    if transaction_type_object.negative?
      self.amount = -self.amount
    end
  end

  # def modify_date
  #   date = changed_attributes[:date]
  #   if date.present?
  #     self.date = date
  #   end
  # end

  def self.by_envelope(params)
    self.where(envelope_id: params[:envelope_id])
  end

  def self.by_institution(params)
    self.where(institutionable_id: params[:institutionable_id])
  end

  def institution_name
    Bank.find(institutionable_id).name
  end

  def transaction_type_object
    TransactionType.find_by_name transaction_type
  end
end
