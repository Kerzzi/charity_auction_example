class CreateAuctionAdmins < ActiveRecord::Migration
  def change
    create_table :auction_admins do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :auction, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
