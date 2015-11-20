FactoryGirl.define do
  factory :organization do
    sequence(:name) { |n| "My name #{n}" }
  end

end
