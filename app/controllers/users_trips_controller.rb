class UsersTripsController < ApplicationController
	def create
		@trip = Trip.find(params[:trip_id])
		if @trip.users.count < @trip.spots
			current_user.signup(@trip, 0)
		else
			current_user.signup(@trip, 1)
		end
		redirect_to :back
	end

	def destroy
		user_trip = UsersTrip.find(params[:id])
		trip = Trip.find(user_trip.trip_id)
		car = trip.carpools.find_by(user_id: user_trip.user_id)
		if !car.nil?
			car.destroy
		end
		user_trip.destroy
    	redirect_to :back
	end

	def edit
		@user_trip = UsersTrip.find(params[:user_trip_id])
	end
end
