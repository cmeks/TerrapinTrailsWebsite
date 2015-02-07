class UsersController < ApplicationController
	  def show
    	@user = User.find(params[:id])
      @current_trips = Array.new
      if @user.role == 1
        @position = "Member"
      elsif @user.role == 2
        @position = "Trip Leader"
      elsif @user.role == 3
        @position = "Trail Maintenance Officer"
      elsif @user.role == 4
        @position = "Director of Outreach"
      elsif @user.role == 5
        @position = "Secretary"
      elsif @user.role == 6
        @position = "Trip Manager"
      elsif @user.role == 7
        @position = "Gear Manager"
      elsif @user.role == 8
        @position = "Vice President"
      elsif @user.role == 9
        @position = "President"
      else
        @position = "Webmaster"
      end

      if @user.trips.count > 0
        @user.trips.each do |trip|
          if !(trip.end_date < Time.now)
            @current_trips.push(trip)
          end
        end
      end
  	end

  	def new
  		@user = User.new
  	end

  	def create
    	@user = User.new(user_params)  
    	if @user.save
    		log_in @user
    		flash[:success] = "Welcome to the Terrapin Trail Club!"
      		redirect_to '/trips'
    	else
      		render 'new'
    	end
  	end

    def index
      @users = User.all.order('name asc')
    end

    def role_change
      user = User.find(params['user']['id'])
      if user.update_attribute(:role, params[:role])
        flash[:success] = "Users role updated"
        redirect_to '/users'
      else
        flash[:danger] = "There was an error, the User's role was not changed"
        redirect_to '/change_role'
      end
    end

  	private

  		def user_params
    		params.require(:user).permit(:name, :email, :password, 
    			:password_confirmation, :role)
    	end


end
