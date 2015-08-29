# Envelope
#
# id:          integer
# category:    string (255)
# deleted:     boolean, default: false
# created_at:  datetime
# updated_at:  datetime
# total:       decimal, precision: 11, scale: 2
# user_id:     integer

class Envelope < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  validates_presence_of :category, :user_id
end
