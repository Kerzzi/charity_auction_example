class Auction < ActiveRecord::Base
  validate :ends_at_after_starts_at
  validate :donation_window_ends_at_after_starts_at
  validates :time_zone_id, inclusion: { in: ActiveSupport::TimeZone.all.map { |tz| tz.tzinfo.identifier } }, allow_blank: true
  validates :organization, presence: true
  has_many :auction_admins
  has_many :donations
  belongs_to :organization

  private 
  def donation_window_ends_at_after_starts_at
    return unless starts_at && donation_window_ends_at

    if starts_at <= donation_window_ends_at
      errors.add :starts_at, "must be greater than donation_window_ends_at"
    end
  end

  def ends_at_after_starts_at
    return unless starts_at && ends_at

    if ends_at <= starts_at
      errors.add :ends_at, "must be greater than starts_at"
    end
  end


end
