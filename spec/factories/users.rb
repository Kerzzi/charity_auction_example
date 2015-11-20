FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Sean #{n}" }
    password "12344321" 
    sequence(:mobile_phone_number) { |n| "+131312312#{n}" }
    sequence(:email_address) { |n| "my_mail_#{n}@example.com" }
    physical_address "123 Main St\n Anytown, NY 123"
  end

end
