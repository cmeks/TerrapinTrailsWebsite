class AddFieldToUsersTrips < ActiveRecord::Migration
  def change
  	add_column :users_trips, :on_waitlist, :integer
  end
end
