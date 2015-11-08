class Donation < ActiveRecord::Base
  belongs_to :auction
  belongs_to :bid_type
  belongs_to :donor, class_name: "User"

  validates :donor, presence: true
  validates :auction, presence: true
  validates :quantity, numericality: { greater_than: 0 }, allow_nil: true
end
