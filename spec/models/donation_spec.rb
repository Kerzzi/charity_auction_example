require 'rails_helper'

RSpec.describe Donation do
  [
    "title",
    "description",
    "quantity",
    "redemption_window_starts_at",
    "redemption_window_ends_at",
    "minimum_bid_amount",
    "estimated_value_amount",
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

  #it { is_expected.to have_many :bids }

  it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0).allow_nil }
  it { is_expected.to validate_numericality_of(:minimum_bid_amount).is_greater_than(0).allow_nil }

  it "validates that quantity is either nil or greater than 0" do
    subject.quantity = nil
    subject.valid?
    expect(subject.errors[:quantity]).to be_empty

    subject.quantity = 0
    subject.valid?
    expect(subject.errors[:quantity]).to include "must be greater than 0"
  end

  it "validates that redemption_windows_ends_at is after redemption_windows_starts_at" do
    subject.redemption_window_starts_at = DateTime.new(2015,10,10,11,00)
    subject.redemption_window_ends_at = subject.redemption_window_starts_at
    subject.valid?
    expect(subject.errors[:redemption_window_ends_at]).to include "must be greater than redemption_window_starts_at"
  end

  it { is_expected.to validate_numericality_of(:estimated_value_amount).is_greater_than_or_equal_to(0).allow_nil }

  it "defaults the admin_follow_up_needed to false" do
    expect(subject.admin_follow_up_needed).to eq false
  end

  it "has the fulfillment_type enum definition" do
    expect(described_class.fulfillment_types).to eq({
      "item" => 0,
      "certificate" => 1
    })
  end

  it "has a nil fulfillment_type after initialization" do
    expect(subject.fulfillment_type).to eq nil
  end

end
