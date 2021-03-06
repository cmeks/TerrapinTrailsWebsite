class UsersTrip < ActiveRecord::Base
	#associations
  	belongs_to :user
  	belongs_to :trip
  	has_many :users_cars, dependent: :destroy
    
    #make sure user_trips are ordered by the time they were created at
    default_scope -> { order(created_at: :asc) }

  	#validations
  	validates :user_id, presence: true
  	validates :trip_id, presence: true
  	validates :on_waitlist, presence: true

  	def join_car(car)
  		users_cars.create(carpool_id: car.id)
  	end
end
