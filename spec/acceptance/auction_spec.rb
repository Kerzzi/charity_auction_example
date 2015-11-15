require 'rspec_api_documentation_helper'

RSpec.resource "Auction" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "auction parameters" do
    parameter "starts-at", <<-DESC, scope: :attributes
      The time at which auction begins in UTC.
    DESC

    parameter "ends-at", <<-DESC, scope: :attributes
      The time at which auction ends in UTC.
    DESC

    parameter "time-zone-id", <<-DESC, scope: :attributes
      The time zone id that should be used to localize the times for the auction.
      For example, "America/New_York".
    DESC

    parameter "physical-address", <<-DESC, scope: :attributes
      The physical address at which the auction will be held.
    DESC

    parameter "name", <<-DESC, scope: :attributes
      The name of the auction.
    DESC

    parameter "donation-window-ends-at", <<-DESC, scope: :attributes
      The time in UTC after which donation can no longer be accepted.
    DESC

    parameter "organization", <<-DESC, required: true, scope: :relationships
      The organization to which the auction belongs.
    DESC

    parameter "type", <<-DESC, required: true
      The type of the resource. Must be 'auctions'.
    DESC

    let "type" do
      "auctions"
    end
  end

  post "v1/auctions" do
    include_context "auction parameters"

    let! :persisted_organization do
      FactoryGirl.create(:organization)
    end

    let "organization" do {
      data: {
        type: "organizations",
        id: persisted_organization.id.to_s
      }
    }
    end

    let "starts_at" do
      Time.utc(2015,10,17,11,0).as_json
    end

    let "ends_at" do
      Time.utc(2015,10,19,11,0).as_json
    end

    let "name" do
      "Charity Auction"
    end

    let "time-zone-id" do
      "America/New_York"
    end

    let "physical-address" do
      "America/New_York 1st"
    end

    let "donation_window_ends_at" do
      Time.utc(2015,10,15,11,0).as_json
    end

    example_request "POST /v1/auctions" do
      expect(status).to eq 201
    end
  end

  get "/v1/auctions" do
    before do
      2.times do
        FactoryGirl.create(:auction)
      end
    end
    
    example_request "GET /v1/auctions" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 2
    end
  end

  patch "/v1/auctions/:auction_id" do
    include_context "auction parameters"
    
    let :persisted_auction do
      FactoryGirl.create(:auction)
    end

    parameter "id", "The id of the resource", required: true

    let "id" do
      persisted_auction.id.to_s
    end
    
    let "name" do
      "Scary Fundraiser"
    end

    let "auction_id" do
      persisted_auction.id.to_s
    end

    example_request "PATCH /v1/auctions/:id" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"]["attributes"]["name"]).to eq public_send("name")
    end
  end

  get "/v1/auctions/:auction_id" do
    let! :persisted_auction do
      FactoryGirl.create(:auction)
    end

    let "auction_id" do
      persisted_auction.id.to_s
    end

    example_request "GET /v1/auctions/:id" do
      expect(status).to eq 200
    end
  end

  delete "v1/auctions/:auction_id" do
    let! :persisted_auction do
      FactoryGirl.create(:auction)
    end

    let "auction_id" do
      persisted_auction.id.to_s
    end

    example_request "DELETE /v1/auctions/:id" do
      expect(status).to eq 204
    end
  end

end
