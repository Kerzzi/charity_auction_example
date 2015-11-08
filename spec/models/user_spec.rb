require 'rails_helper'

RSpec.describe User, type: :model do
  ["name","mobile_phone_number","email_address","physical_address"].each do |required_attribute|
    it { is_expected.to have_attribute required_attribute }
    it { is_expected.to validate_presence_of required_attribute }
  end


  it "validates the uniqueness of mobile_phone_number" do
    subject = FactoryGirl.create(:user)
    duplicate = FactoryGirl.build(:user, mobile_phone_number: subject.mobile_phone_number)
    duplicate.valid?
    expect(duplicate.errors[:mobile_phone_number]).to include "has already been taken"
  end

  it "validates the uniqueness of email_address" do
    subject = FactoryGirl.create(:user)
    duplicate = FactoryGirl.build(:user, email_address: subject.email_address)
    duplicate.valid?
    expect(duplicate.errors[:email_address]).to include "has already been taken"
  end
end
