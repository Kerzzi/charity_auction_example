require 'rails_helper'

RSpec.describe AuctionAdmin, type: :model do
  it { is_expected.to belong_to :auction }
  it { is_expected.to belong_to :user }

  it { is_expected.to validate_presence_of :auction }
  it { is_expected.to validate_presence_of :user }
end
