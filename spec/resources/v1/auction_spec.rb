module V1
  RSpec.describe AuctionResource do

    let :creatable_fields do
      [:starts_at,:ends_at,:name,:donation_window_ends_at,:physical_address,:time_zone_id,:organization].sort
    end 

    subject do
      described_class.new Auction.new, {}
    end

    it "has the expected creatable attributes" do
      expect(described_class.creatable_fields({}).sort).to eq creatable_fields
    end
    it "has the expected updatable attributes" do
      expect(described_class.updatable_fields({}).sort).to eq creatable_fields
    end
    it "has the expected fetchable attributes" do
      expect(subject.fetchable_fields.sort).to eq (creatable_fields + [:id, :created_at,:updated_at]).sort
    end
  end
end