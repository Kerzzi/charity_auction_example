require 'rspec_api_documentation_helper'

RSpec.resource "Donations" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "donation parameters" do
    parameter "type", "The type of the resource. Always 'donations'.", required: true

    let "type" do
      "donations"
    end

    parameter "title", <<-DESC, scope: :attributes
       The title of the donation.
    DESC
    parameter "description", <<-DESC, scope: :attributes
       The description of the donation.
    DESC
    parameter "quantity", <<-DESC, scope: :attributes
       The number of units of the described item included in the donation.
    DESC
    parameter "redemption-window-starts-at", <<-DESC, scope: :attributes
      The earliest time in UTC at which the donation may be redeemed.
    DESC
    parameter "redemption-window-ends-at", <<-DESC, scope: :attributes
      The latest time in UTC at which the donation may be redeemed.
    DESC
    parameter "estimated-value-amount", <<-DESC, scope: :attributes
      The estimated value per unit of the donation item.
    DESC
    parameter "minimum-bid-amount", <<-DESC, scope: :attributes
      The minimum bid amount per unit of the donation item.
    DESC
    parameter "admin-follow-up-needed", <<-DESC, scope: :attributes
      Does an auction administrator need to follow with the donor about the item.
    DESC
    parameter "fulfillment-type", <<-DESC, scope: :attributes
      The way in which the item will be fulfilled. Valid values are 'item','certificate'.
    DESC
    parameter "bid-type", <<-DESC, scope: :relationships
      The type of bid that will be conducted for this item.
    DESC
    parameter "auction", <<-DESC, scope: :relationships
      The auction to which this donation is made.
    DESC
    parameter "donor", <<-DESC, scope: :relationships
      The user to which the donation belongs. 
    DESC
  end

  post "/v1/donations" do
    include_context "donation parameters"
    let "title" do
      "Weekend at my ski house"
    end

    let "description" do
      "Weeked at fancy ski house"
    end

    let "display-description" do
      "Nice description"
    end

    let :persisted_donor do
      FactoryGirl.create(:user)
    end

    let "donor" do
      {
        data: {
          type: "users",
          id: persisted_donor.id.to_s
        }
      }
    end

    let :persisted_auction do
      FactoryGirl.create(:auction)
    end

    let "auction" do
      {
        data: {
          type: "auctions",
          id: persisted_auction.id.to_s
        }
      }
    end

    example_request "POST /v1/donations" do
      expect(status).to eq 201
    end
  end

  get "/v1/donations" do
    before do
      2.times do
        FactoryGirl.create(:donation)
      end
    end

    example_request "GET /v1/donations" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 2
    end
  end

  get "/v1/donations/:donation_id" do
    let :persisted_donation do
      FactoryGirl.create(:donation)
    end

    parameter "id", "id of the donation", required: true

    let "id" do
      persisted_donation.id.to_s
    end

    parameter "donation_id", "donation id", required: true, scope: :attributes

    let "donation_id" do
      persisted_donation.id.to_s
    end

    example_request "GET /v1/donations/:donation_id" do
      expect(status).to eq 200
    end
  end

  patch "/v1/donations/:donation_id" do
    include_context "donation parameters"
    let :persisted_donation do
      FactoryGirl.create(:donation)
    end

    parameter "id", "id of the donation", required: true

    let "id" do
      persisted_donation.id.to_s
    end

    let "donation_id" do
      persisted_donation.id.to_s
    end

    let "title" do
      "new title"
    end

    example_request "PATCH /v1/donations/:donation_id" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"]["attributes"]["title"]).to eq public_send("title")
    end
  end

  delete "/v1/donations/:donation_id" do
    let :persisted_donation do
      FactoryGirl.create(:donation)
    end

    parameter "id", "id of the donation", required: true

    let "id" do
      persisted_donation.id.to_s
    end

    let "donation_id" do
      persisted_donation.id.to_s
    end

    example_request "DELETE /v1/donations/:donation_id" do
      expect(status).to eq 204
    end
  end
end
