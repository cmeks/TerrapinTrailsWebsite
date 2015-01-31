class UsersCarsController < ApplicationController
	def create
    @user_trip = UsersTrip.find(params[:users_trip_id])
    @car = Carpool.find(params[:car_id])
    @user_trip.join_car(@car)
    redirect_to :back
	end

  def create_destroy
    @user_trip = UsersTrip.find(params[:users_trip_id])
    @car = Carpool.find(params[:car_id])
    @user_car = UsersCar.find(params[:users_cars_id]) 
    @user_car.destroy
    @user_trip.join_car(@car)
    redirect_to :back
  end

	def destroy
    user_car = UsersCar.find(params[:id])
		user_car.destroy
    redirect_to :back
	end
end