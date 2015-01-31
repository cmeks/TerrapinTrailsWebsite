class UsersCar < ActiveRecord::Base
	#associations
	belongs_to :users_trip
	belongs_to :carpool

	#validations 
	validates :users_trip_id, presence: true
  	validates :carpool_id, presence: true
end
