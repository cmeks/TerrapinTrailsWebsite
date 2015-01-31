class CreateUsersCars < ActiveRecord::Migration
  def change
    create_table :users_cars do |t|
	  t.belongs_to :carpool, index: true
  	  t.belongs_to :users_trip, index: true 

      t.timestamps null: false
    end
  end
end
