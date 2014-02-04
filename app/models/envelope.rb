class Envelope < ActiveRecord::Base
  belongs_to :bank

  validates :category, presence: true
  validates :total, presence: true
  validates :bank_id, presence: true
end
