class CarpoolsController < ApplicationController
	def new
		@carpool = Carpool.new
	end

	def create
		@carpool = Carpool.new(carpool_params)
		if @carpool.save
			flash[:success] = "Your Car has successfully been created for this Trip!"
			@trip = Trip.find(current_trip)
	      	redirect_to @trip 
	    else
	    	render 'new'
	    end
	end

	def destroy
		car = Carpool.find(params[:id])
		car.destroy
    	redirect_to :back
	end

	def edit
		@car = Carpool.find(params[:car_id])
	end

	def update
    	@car = Carpool.find(params[:id])
    	if @car.update_attributes(carpool_params)
     	 	flash[:success] = "Car updated"
      		redirect_to @car.trip
    	else
      		render 'edit'
    	end
  	end

	private

		def carpool_params
    		params.require(:carpool).permit(:nickname, :make, :model, :year, :user_id, :trip_id, :color, :leave_time, :leave_location, :seats, :message)
    	end
end