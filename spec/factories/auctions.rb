FactoryGirl.define do
  factory :auction do
    starts_at "2015-11-08 21:49:27"
    ends_at "2015-11-08 22:49:28"
    time_zone_id "America/New_York"
    physical_address "123 Main st\nAnytown, NY 21201 USA"
    name "2016 Charity Auction"
    donation_window_ends_at "2015-11-07 21:49:27"
  end
end
