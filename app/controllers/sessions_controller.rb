class SessionsController < ApplicationController
	layout "login"

	def new
	
	end

	# creer une nouvelle session pour un utilisateur s'il est correctement authentifié
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

	# détruit la session de l'utilisateur courant 
	def destroy
		sign_out 
		redirect_to signin_path 
	end
end
