require 'rake'
require 'rspec_api_documentation_helper'

RSpec.resource "Donation Categories" do
  header "Content-Type", "application/vnd.api+json"

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

    example_request "GET /v1/donation-categories/:donation_category_id" do
      expect(status).to eq 200
    end
  end
end
