require 'spec_helper'
require 'rspec_api_documentation_helper'

RSpec.resource "Users" do
  post "/v1/users" do
    parameter "name", <<-DESC, scope: :attributes, required: true
      The name of the user
    DESC

    let "name" do
      "Sean Devine"
    end

    parameter "mobile-phone-number", <<-DESC, scope: :attributes, required: true
      The mobile phone of the user.
    DESC

    let "mobile-phone-number" do
      "+80732233444"
    end

    parameter "email-address", <<-DESC, scope: :attributes, required: true
      The email address of the user.
    DESC

    let "email-address" do
      "test@test.com"
    end

    parameter "physical-address", <<-DESC, scope: :attributes, required: true
      The physical address of the user.
    DESC

    let "physical-address" do
      "bush street 15a"
    end

    example_request "Create user" do
      expect(status).to eq 201
    end
  end
end
