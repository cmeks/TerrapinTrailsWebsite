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
		user_trip.destroy
    	redirect_to :back
	end
end
