require 'rails_helper'

RSpec.describe Donation do
  [
    "title",
    "description",
    "quantity",
    "redemption_window_starts_at",
    "redemption_window_ends_at",
    "minimum_bid_dollars",
    "estimated_value_dollars",
    "display_description",
    "admin_follow_up_needed",
    "fulfillment_type"
  ].each do |attribute|
    it { is_expected.to have_attribute attribute }  
  end

  it { is_expected.to validate_presence_of :auction }
  it { is_expected.to validate_presence_of :donor }

  it { is_expected.to belong_to :auction }
  it { is_expected.to belong_to :donor }

  it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0).allow_nil }

  it "validates that quantity is either nil or greater than 0" do
    subject.quantity = nil
    subject.valid?
    expect(subject.errors[:quantity]).to be_empty

    subject.quantity = 0
    subject.valid?
    expect(subject.errors[:quantity]).to include "must be greater than 0"
  end
end
