require 'rails_helper'

RSpec.describe Bid, type: :model do

  it { is_expected.to belong_to :donation }
  it { is_expected.to belong_to :bidder }

  ["amount_dollars","quantity","placed_at"].each do |required_attribute|
    it { is_expected.to have_attribute required_attribute }
  end

  ["donation","bidder","amount_dollars","quantity","placed_at"].each do |required_attribute|
    it { is_expected.to validate_presence_of required_attribute }
  end

  it { is_expected.to validate_numericality_of(:amount_dollars).is_greater_than(0) }
  #it { is_expected.to validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
  it "validates that the quantity is between 1 and the donation's quanity" do
    subject.donation = Donation.new(quantity: 2)
    subject.quantity = 0
    subject.valid?
    expect(subject.errors[:quantity]).to include "must be greater than or equal to 1 and less than or equal to 2"
  end
end
