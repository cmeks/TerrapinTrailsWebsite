class AddBikeQuestionToTrips < ActiveRecord::Migration
  def change
  	add_column :trips, :ask_bike, :integer
  end
end
