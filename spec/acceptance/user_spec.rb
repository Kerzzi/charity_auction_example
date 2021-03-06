require 'rspec_api_documentation_helper'

RSpec.resource "Users" do
  header "Content-Type", "application/vnd.api+json"

  shared_context "user_parameters" do
    let "type" do
      "users"
    end

    parameter "type", <<-DESC, required: true 
      The type of the resource. Must be users.  
    DESC

    parameter "password", <<-DESC, scope: :attributes, required: true
      The password of the user
    DESC

    parameter "name", <<-DESC, scope: :attributes, required: true
      The name of the user
    DESC
    parameter "mobile-phone-number", <<-DESC, scope: :attributes, required: true 
      The mobile phone of the user.
    DESC

    parameter "email-address", <<-DESC, scope: :attributes, required: true
      The email address of the user.
    DESC

    parameter "physical-address", <<-DESC, scope: :attributes, required: true
      The physical address of the user.
    DESC
  end

  post "/v1/users" do
    include_context "user_parameters"

    let "password" do
      "12344321"
    end

    let "name" do
      "Sean Devine"
    end

    let "mobile-phone-number" do
      "+80732233444"
    end

    let "email-address" do
      "test@test.com"
    end

    let "physical-address" do
      "bush street 15a"
    end

    example_request "POST /v1/users" do
      expect(status).to eq 201
      user = JSON.parse(response_body)
      expect(user["data"]["attributes"]["email-address"]).to eq send("email-address")
    end
  end

  get "v1/users/:id" do
    let! :persisted_user do
      FactoryGirl.create(:user)
    end

    let :id do
      persisted_user.id.to_s
    end

    example_request "GET /v1/users/:id" do
      expect(status).to eq 200
    end
  end

  get "/v1/users/me" do
    let! :persisted_user do
      FactoryGirl.create(:user)
    end

    let :access_token do
      Doorkeeper::AccessToken.create!(resource_owner_id: persisted_user.id)
    end

    before do
      header "Authorization", "Bearer #{access_token.token}"
    end

    let "email_address" do
      persisted_user.email_address
    end

    example_request "GET /v1/users/me" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"]["attributes"]["email-address"]).to eq public_send("email_address")
    end
  end

  patch "v1/users/:user_id" do
    include_context "user_parameters"

    let! :persisted_user do
      FactoryGirl.create(:user)
    end

    parameter "id", <<-DESC, required: true
      The id of the user.
    DESC

    let :user_id do
      persisted_user.id.to_s
    end

    let :id do
      persisted_user.id.to_s
    end

    let "name" do
      "Theresa Devine"
    end

    example_request "PATCH /v1/users/:id" do
      expect(status).to eq 200
      user = JSON.parse(response_body)
      expect(user["data"]["attributes"]["name"]).to eq public_send("name")
    end
  end

  get "/v1/users" do
    before do
      3.times do
        FactoryGirl.create(:user)
      end
    end 

    example_request "GET /v1/users" do
      expect(status).to eq 200
      users = JSON.parse(response_body)
      expect(users["data"].size).to eq 3
    end
  end

=begin
  delete "/v1/users/:user_id" do
    let :persisted_user do
      FactoryGirl.create(:user)
    end

    let "user_id" do
      persisted_user.id.to_s
    end

    example "DELETE /v1/users/:user_id" do
      no_doc do
        expect{do_request}.to raise_error(ActionController::RoutingError)
      end
    end
  end
=end

end
