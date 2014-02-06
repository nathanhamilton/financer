class Envelope < ActiveRecord::Base
  belongs_to :bank
  has_many :transactions

  validates_presence_of :bank_id, :category, :total
end
