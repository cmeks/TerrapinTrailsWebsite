class AddFieldsToCarpools < ActiveRecord::Migration
  def change
  	add_column :carpools, :make, :string
  	add_column :carpools, :model, :string
  	add_column :carpools, :year, :integer
  	add_column :carpools, :color, :string
  	add_column :carpools, :leave_time, :datetime
  	add_column :carpools, :leave_location, :string
  	add_column :carpools, :seats, :integer
  	add_column :carpools, :nickname, :string
  	add_column :carpools, :message, :text
  end
end
