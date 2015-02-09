class UsersController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update]
    before_action :correct_user,   only: [:edit, :update]
    
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
      render :layout => 'forms'
  	end

  	def create
    	@user = User.new(user_params)
      @user.role = 1  
    	if @user.save
    		@user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_url
    	else
      		render 'new'
    	end
  	end

    def index
      @users = User.all.order('last_name asc')
    end

    def edit
      @user = User.find(params[:id]) 
    end
    
    def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
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
    		params.require(:user).permit(:first_name, :last_name, :email, :password, 
    			:password_confirmation, :ec_name, :ec_type, :ec_phone1, :ec_phone2, :ec_email)
    	end

      # Before filters

      # Confirms a logged-in user.
      def logged_in_user
        unless logged_in?
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end

      # Confirms the correct user.
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless @user == current_user
      end


end
