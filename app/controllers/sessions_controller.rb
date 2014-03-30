class SessionsController < ApplicationController
	layout "login"

	def new
	
	end

	# Create new session for current user if successfully logged-in
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or user
		else
			flash.now[:danger] = 'Invalid email/password combination'
			render 'new'
		end
	end

	# Destroy current user's session
	def destroy
		sign_out 
		redirect_to signin_path 
	end
end
