class UsersController < ApplicationController

	  def show
    	@user = User.find(params[:id])
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
