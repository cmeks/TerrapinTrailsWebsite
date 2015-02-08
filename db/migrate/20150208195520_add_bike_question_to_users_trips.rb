class AddBikeQuestionToUsersTrips < ActiveRecord::Migration
  def change
  	add_column :users_trips, :ask_bike, :integer
  end
end
