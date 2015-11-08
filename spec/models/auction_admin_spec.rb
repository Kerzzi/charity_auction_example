require 'rails_helper'

RSpec.describe AuctionAdmin, type: :model do
  it { is_expected.to belong_to :auction }
  it { is_expected.to belong_to :user }

  it { is_expected.to validate_presence_of :auction }
  it { is_expected.to validate_presence_of :user }

  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:auction_id) }

  it "validates the uniqueness of user_id scoped to auction_id" do
    original = FactoryGirl.create(:auction_admin)
    dublicate = FactoryGirl.build(:auction_admin, user: original.user, auction: original.auction)
    dublicate.valid?
    expect(dublicate.errors[:user_id]).to include "has already been taken"
  end
end
