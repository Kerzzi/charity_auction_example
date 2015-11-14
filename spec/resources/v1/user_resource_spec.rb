module V1
  RSpec.describe UserResource do

    let :createable_fields do
      [:name,:mobile_phone_number,:email_address,:physical_address,:password].sort
    end

    subject do
      described_class.new User.new, {}
    end

    it "has the expected createable fields" do
      expect(described_class.createable_fields({}).sort).to eq createable_fields
    end

    it "has the expected updatable fields" do
      expect(described_class.updatable_fields({}).sort).to eq createable_fields
    end

    it "has the expected fetchable fields" do
      expect(subject.fetchable_fields.sort).to eq (createable_fields + [:id,:created_at,:updated_at] - [:password]).sort
    end
  end
end
