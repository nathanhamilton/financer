# Envelope
#
# id:          integer
# bank_id:     integer
# category:    string (255)
# deleted:     boolean, default: false
# created_at:  datetime
# updated_at:  datetime
# total:       decimal, precision: 11, scale: 2

class Envelope < ActiveRecord::Base
  belongs_to :bank
  has_many :transactions, dependent: :destroy

  validates_presence_of :bank_id, :category
end
