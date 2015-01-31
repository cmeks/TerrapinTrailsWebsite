class AddFieldsToTrips < ActiveRecord::Migration
  def change
  	add_column :trips, :experience_level, :string
  	add_column :trips, :pretrip_datetime, :datetime
  	add_column :trips, :pretrip_location, :string
  	add_column :trips, :cost, :integer
  	add_column :trips, :location, :string
  	add_column :trips, :spots, :integer
  end
end
