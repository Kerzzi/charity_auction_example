class Bid < ActiveRecord::Base
  belongs_to :donation
  belongs_to :bidder, class_name: "User"

  validates :amount_dollars, presence: true, numericality: { greater_than: 0 }
  validates :bidder, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :placed_at, presence: true
  validates :donation, presence: true

  validate :quantity_between_1_and_donation_quanity

  def quantity_between_1_and_donation_quanity
    return unless quantity && donation.try(:quantity)

    unless 1 <= quantity && quantity <= donation.quantity
      errors.add :quantity, "must be greater than or equal to 1 and less than or equal to #{donation.quantity}"
    end
  end
end
