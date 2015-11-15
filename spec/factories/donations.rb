FactoryGirl.define do
  factory :donation do
    title "MyString"
    description "MyText"
    quantity 1
    association :auction, strategy: :build
    association :bid_type, strategy: :build
    association :donor, factory: :user, strategy: :build
    redemption_window_starts_at "2015-11-08 17:05:25"
    redemption_window_ends_at "2015-11-08 17:05:35"
    estimated_value_amount 1
    minimum_bid_amount 1
    display_description "MyString"
    admin_follow_up_needed false
    item_number "MyString"
    fulfillment_type 1
  end

end
