require "rspec_api_documentation_helper"

RSpec.resource "Organizations" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "organization parameters" do
    parameter "type", <<-DESC, required: true
      The type of the resource. Always 'organization'
    DESC

    let "type" do
      "organizations"
    end

  end

  post "v1/organizations" do
    include_context "organization parameters"
    parameter "name", <<-DESC, required: true, scope: :attributes
      The name of the organization.
    DESC

    let "name" do
      "1st Street Elementary School"
    end

    example_request "POST v1/organizations" do
      expect(status).to eq 201
    end
  end

  shared_context "with a persisted organization" do
    let! :persisted_organization do
      FactoryGirl.create(:organization)
    end

    let "organization_id" do
      persisted_organization.id.to_s
    end
  end

  get "/v1/organizations/:organization_id" do
    include_context "with a persisted organization"
    example_request "GET /v1/organizations/:organization_id" do
      expect(status).to eq 200
    end
  end

  patch "/v1/organizations/:organization_id" do
    include_context "organization parameters"
    include_context "with a persisted organization"

    parameter "id", <<-DESC, require: true
      The id of the organization
    DESC

    let :id do
      persisted_organization.id.to_s
    end

    parameter "name", <<-DESC, required: true, scope: :attributes
      The name of the organization
    DESC

    let "name" do
      "2nd Street High School"
    end

    example_request "PATCH /v1/organizations/:organization_id" do
      expect(status).to eq 200
      puts response_body
      organization = JSON.parse(response_body)
      expect(organization["data"]["attributes"]["name"]).to eq public_send("name")
    end
  end
end
