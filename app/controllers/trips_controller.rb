class TripsController < ApplicationController
	def index
		@trips = Trip.all
		@current = Array.new
		@outgoing = Array.new
		@past = Array.new
		@leading = Array.new
		@trips.each do |f|
			if logged_in? && f.user == current_user && f.end_date > Time.now
				@leading.push(f)
			elsif f.start_date < Time.now && f.end_date > Time.now
				@outgoing.push(f)
			elsif f.start_date > Time.now && f.end_date > Time.now
				@current.push(f)
			else 
				@past.push(f)
			end
		end
	end

	def show
		@trip = Trip.find(params[:id])
		@users = @trip.users
		@carpools = @trip.carpools
		@on_trip = @trip.users.include?(current_user)
		if logged_in?
			@car = current_user.carpools.find_by(trip_id: @trip.id)
		end
		if @on_trip == true
			@user_trip = @trip.users_trips.find_by(user_id: current_user.id)
		end
	end

	def new
		@trip = Trip.new
	end

	def create
		@trip = Trip.new(trip_params)
		if @trip.save
    		flash[:success] = "The Trip has successfully been created!"
      		redirect_to @trip
    	else
      		render 'new'
    	end
	end

	def edit
		@trip = Trip.find(params[:id])
	end

	def update
    	@trip = Trip.find(params[:id])
    	if @trip.update_attributes(trip_params)
     	 	flash[:success] = "Trip updated"
      		redirect_to @trip
    	else
      		render 'edit'
    	end
  	end

	def car
		update_trip_id(params[:trip_id])
		redirect_to newCar_path
	end

	def destroy
		Trip.find(params[:id]).destroy
		flash[:success] = "Your Trip was successfully deleted"
    	redirect_to trips_url
	end

	private

		def trip_params
    		params.require(:trip).permit(:name, :start_date, :end_date, :description, :user_id, :pretrip_location, :pretrip_datetime, :cost, :spots, :location, :experience_level)
    	end
end
