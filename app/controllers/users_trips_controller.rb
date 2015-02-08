class UsersTripsController < ApplicationController
	def create
		@trip = Trip.find(params[:trip_id])
		@should_edit = params[:questions]
		if @trip.users.count < @trip.spots
			current_user.signup(@trip, 0)
		else
			current_user.signup(@trip, 1)
		end

		if @should_edit == "true"
			user_trip = UsersTrip.find_by(trip_id: @trip.id, user_id: current_user.id)
			redirect_to edit_user_trip_path(user_trip_id: user_trip.id)
		else 
			redirect_to :back
		end
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
		@trip = @user_trip.trip
	end

	def update
		@user_trip = UsersTrip.find(params[:id])
		if @user_trip.update_attributes(users_trips_params)
     	 	flash[:success] = "Trip signup info updated"
      		redirect_to @user_trip.trip
    	else
      		render 'edit'
    	end
	end

	private
		def users_trips_params
			params.require(:users_trip).permit(:ask_bag, :ask_tent, :ask_pad, :ask_diet, :ask_bike_rack, :ask_helmet, :ask_headlamp, :ask_harness, :ask_kayak, :ask_climbing_shoes, :ask_kneepads, :ask_pack, :ask_bike)
		end
end
