module V1
  RSpec.describe DonationResource do
    let :creatable_fields do
      [ 
        :title,
        :description,
        :quantity,
        :item_number,
        :redemption_window_starts_at,
        :redemption_window_ends_at,
        :estimated_value_amount,
        :minimum_bid_amount,
        :display_description,
        :admin_follow_up_needed, :bid_type,
        :auction,
        :donor,
        :fulfillment_type
      ].sort
    end

    subject do
      described_class.new Donation.new, {}
    end

    it "has the correct creatable fields" do
      expect(described_class.creatable_fields({}).sort).to eq creatable_fields
    end

    it "has the correct updatable fields" do
      expect(described_class.updatable_fields({}).sort).to eq creatable_fields
    end

    it "has the correct fetchable fields" do
      expect(subject.fetchable_fields.sort).to eq (creatable_fields + [:id,:created_at,:updated_at]).sort
    end
  end
end
