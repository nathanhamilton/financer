class Envelope < ActiveRecord::Base
  belongs_to :bank
  has_many :transactions, dependent: :destroy

  validates_presence_of :bank_id, :category
end
