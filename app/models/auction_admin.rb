class AuctionAdmin < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validates :user, presence: true
  validates :auction, presence: true

  validates :user_id, uniqueness: { scope: [:auction_id] }
end
