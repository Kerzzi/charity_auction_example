FactoryGirl.define do
  factory :user do
    name "Sean Devine"
    password "12344321" 
    sequence(:mobile_phone_number) { |n| "+1888555121#{n}" }
    sequence(:email_address) { |n| "my_mail#{n}@example.com" }
    physical_address "123 Main St\n Anytown, NY 123"
  end

end
