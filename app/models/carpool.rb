class Carpool < ActiveRecord::Base
	#associations
	belongs_to :trip
	belongs_to :user
	has_many :users_cars, dependent: :destroy
	has_many :users_trips, :through => :users_cars

	#validations
	validates :trip_id, presence: true
	validates :make, presence: true
	validates :user_id, presence: true
	validates :model, presence: true
	validates :leave_time, presence: true
	validates :seats, presence: true
	validates :year, presence: true
end