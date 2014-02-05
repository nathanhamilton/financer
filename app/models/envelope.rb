class Envelope < ActiveRecord::Base
  belongs_to :bank

  validates_presence_of :bank_id, :category, :total
end
