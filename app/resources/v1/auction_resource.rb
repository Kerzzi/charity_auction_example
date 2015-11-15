module V1
  class AuctionResource < BaseResource
    attribute :starts_at
    attribute :ends_at
    attribute :time_zone_id
    attribute :physical_address
    attribute :donation_window_ends_at
    attribute :name

    has_one :organization
  end
end
