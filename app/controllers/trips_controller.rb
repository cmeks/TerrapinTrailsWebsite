class TripsController < ApplicationController
	def index
		@trips = Trip.all
		@current = Array.new
		@outgoing = Array.new
		@past = Array.new
		@leading = Array.new
		@on = Array.new
		@trips.each do |f|
			if logged_in? && f.user == current_user && f.end_date > Time.now
				@leading.push(f)
			elsif logged_in? && f.start_date > Time.now && f.users.include?(current_user)
				@on.push(f)
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
		#@users = @trip.users
		@carpools = @trip.carpools
		@on_trip = @trip.users.include?(current_user)
		@cars_on_trip = Array.new
		@cars_on_waitlist = Array.new
		@waitlist_count = 0
		@on_trip_count = 0
		@bag_count = 0
		@tent_count = 0
		@pad_count = 0
		@pack_count = 0
		@bike_rack_count = 0
		@helmet_count = 0
		@headlamp_count = 0
		@harness_count = 0
		@kayak_count = 0
		@climbing_shoes_count = 0
		@kneepads_count = 0
		@bike_count = 0

		@trip.users_trips.each do |user|
			if user.on_waitlist == 1
				@waitlist_count = @waitlist_count + 1
			else
				@on_trip_count = @on_trip_count + 1
			end

			if @trip.ask_tent == 0 && user.ask_tent == 0 && user.on_waitlist == 0
				@tent_count = @tent_count + 1
			end

			if @trip.ask_bag == 0 && user.ask_bag == 0 && user.on_waitlist == 0
				@bag_count = @bag_count + 1
			end

			if @trip.ask_pad == 0 && user.ask_pad == 0 && user.on_waitlist == 0
				@pad_count = @pad_count + 1
			end

			if @trip.ask_pack == 0 && user.ask_pack == 0 && user.on_waitlist == 0
				@pack_count = @pack_count + 1
			end

			if @trip.ask_bike_rack == 0 && user.ask_bike_rack == 0 && user.on_waitlist == 0
				@bike_rack_count = @bike_rack_count + 1
			end

			if @trip.ask_helmet == 0 && user.ask_helmet == 0 && user.on_waitlist == 0
				@helmet_count = @helmet_count + 1
			end

			if @trip.ask_harness == 0 && user.ask_harness == 0 && user.on_waitlist == 0
				@harness_count = @harness_count + 1
			end

			if @trip.ask_kayak == 0 && user.ask_kayak == 0 && user.on_waitlist == 0
				@kayak_count = @kayak_count + 1
			end

			if @trip.ask_climbing_shoes == 0 && user.ask_climbing_shoes == 0 && user.on_waitlist == 0
				@climbing_shoes_count = @climbing_shoes_count + 1
			end

			if @trip.ask_kneepads == 0 && user.ask_kneepads == 0 && user.on_waitlist == 0
				@kneepads_count = @kneepads_count + 1
			end

			if @trip.ask_bike == 0 && user.ask_bike == 0 && user.on_waitlist == 0
				@bike_count = @bike_count + 1
			end
		end

		if logged_in?
			@car = current_user.carpools.find_by(trip_id: @trip.id)
		end
		if @on_trip == true
			@user_trip = @trip.users_trips.find_by(user_id: current_user.id)
		end

		@carpools.each do |car|
			driver_id = car.user.id
			driver = @trip.users_trips.find_by(user_id: driver_id);
			if driver.on_waitlist == 0
				@cars_on_trip.push(car)
			else
				@cars_on_waitlist.push(car)
			end
		end

		if @trip.status == 0
			@status = "Hidden"
		elsif @trip.status == 1
			@status = "Closed"
		else
			@status = "Open"
		end

		if @trip.ask_bag == 0 || @trip.ask_tent == 0 || @trip.ask_pad == 0 || @trip.ask_pack == 0 || @trip.ask_diet == 0 || @trip.ask_bike_rack == 0 || @trip.ask_helmet == 0 || @trip.ask_headlamp == 0 || @trip.ask_harness == 0 || @trip.ask_kayak == 0 || @trip.ask_climbing_shoes == 0 || @trip.ask_kneepads == 0 || @trip.ask_bike == 0 
			@questions = true
		else
			@questions = false
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

	def off_waitlist
		user_trip = UsersTrip.find(params[:id])
		if user_trip.update_attribute(:on_waitlist, 0)
			flash[:success] = "User pulled on the waitlist"
			redirect_to user_trip.trip
		else
			flash[:danger] = "There was an error, the user was not pulled off the waitlist"
			redirect_to user_trip.trip
		end
	end

	def on_waitlist
		@user_trip = UsersTrip.find(params[:id])
		if @user_trip.update_attribute(:on_waitlist, 1)
			@user_trip.users_cars.each do |user_car|
				user_car.destroy
			end
			flash[:success] = "User put on the waitlist"
			redirect_to @user_trip.trip
		else
			flash[:danger] = "There was an error, the user was not put on the waitlist"
			redirect_to @user_trip.trip
		end
	end

	def destroy
		Trip.find(params[:id]).destroy
		flash[:success] = "Your Trip was successfully deleted"
    	redirect_to trips_url
	end

	private

		def trip_params
    		params.require(:trip).permit(:name, :start_date, :end_date, :description, :user_id, :pretrip_location, :pretrip_datetime, :cost, :spots, :location, :experience_level, :status, :ask_bag, :ask_tent, :ask_pad, :ask_diet, :ask_bike_rack, :ask_helmet, :ask_headlamp, :ask_harness, :ask_kayak, :ask_climbing_shoes, :ask_kneepads, :ask_pack, :ask_bike)
    	end
end