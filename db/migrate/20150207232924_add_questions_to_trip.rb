class AddQuestionsToTrip < ActiveRecord::Migration
  def change
  	add_column :trips, :ask_tent, :integer
  	add_column :trips, :ask_bag, :integer
  	add_column :trips, :ask_pad, :integer
  	add_column :trips, :ask_pack, :integer
  	add_column :trips, :ask_diet, :integer
  	add_column :trips, :ask_bike_rack, :integer
  	add_column :trips, :ask_helmet, :integer
  	add_column :trips, :ask_headlamp, :integer
  	add_column :trips, :ask_harness, :integer
  	add_column :trips, :ask_kayak, :integer
  	add_column :trips, :ask_climbing_shoes, :integer
  	add_column :trips, :ask_kneepads, :integer

  	add_column :users_trips, :ask_tent, :integer
  	add_column :users_trips, :ask_bag, :integer
  	add_column :users_trips, :ask_pad, :integer
  	add_column :users_trips, :ask_pack, :integer
  	add_column :users_trips, :ask_diet, :string
  	add_column :users_trips, :ask_bike_rack, :integer
  	add_column :users_trips, :ask_helmet, :integer
  	add_column :users_trips, :ask_headlamp, :integer
  	add_column :users_trips, :ask_harness, :integer
  	add_column :users_trips, :ask_kayak, :integer
  	add_column :users_trips, :ask_climbing_shoes, :integer
  	add_column :users_trips, :ask_kneepads, :integer
  end
end
