class SessionsController < ApplicationController
	def new
    render :layout => 'forms'
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
    	if user && user.authenticate(params[:session][:password])
      		if user.activated == 1
            log_in user
            params[:session][:remember_me] == '1' ? remember(user) : forget(user)
            redirect_to '/trips'
          else
            message  = "Account not activated. "
            message += "Check your email for the activation link."
            flash[:warning] = message
            redirect_to root_url
          end
    	else
      		# Create an error message.
      		flash[:danger] = 'Invalid email/password combination'

      		redirect_to login_path
    	end
	end

	def destroy
		log_out if logged_in?
    	redirect_to root_url
	end
end
