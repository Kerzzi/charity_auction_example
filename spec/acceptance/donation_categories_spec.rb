require 'rake'
require 'rspec_api_documentation_helper'

RSpec.resource "Donation Categories" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "donation categories parameters" do
    parameter "type", <<-DESC, required: true
      The type of the resource. Must be always 'donation-categories'
    DESC

    let "type" do
      "donation-categories"
    end

    parameter "name", <<-DESC, required: true, scope: :attributes
     The name of the donation category
    DESC
  end

  before do
    CharityAuctionServer::Application.load_tasks
    Rake::Task["seed:donation_categories"].execute
  end

  get "/v1/donation-categories" do
    example_request "GET /v1/donation-categories" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq DonationCategory.count
    end
  end

  get "/v1/donation-categories/:donation_category_id" do
    let :donation_category_id do
      DonationCategory.first.id
    end

    example_request "GET /v1/donation-categories/:id" do
      expect(status).to eq 200
    end
  end

  post "/v1/donation-categories" do
    include_context "donation categories parameters"
    let "name" do
      "Manual Labor"
    end

    example_request "POST /v1/donation-categories" do
      expect(status).to eq 201
    end 
  end

  patch "/v1/donation-categories/:donation_category_id" do
    include_context "donation categories parameters"
    let! :persisted_donation_category do
      FactoryGirl.create(:donation_category, name: "Manual Labor")
    end

    parameter "id", <<-DESC, required: true
      The id of the resource
    DESC

    let "id" do
      donation_category_id
    end

    let :donation_category_id do
      persisted_donation_category.id.to_s
    end

    let "name" do
      "Automated Labor"
    end

    example_request "PATCH /v1/donation-categories/:id" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"]["attributes"]["name"]).to eq public_send("name")
    end 
  end

  delete "/v1/donation-categories/:donation_category_id" do
    let :donation_category_id do
      DonationCategory.first.id.to_s
    end

    example_request "DELETE /v1/donation-categories/:id" do
      expect(status).to eq 204
    end
  end
end
