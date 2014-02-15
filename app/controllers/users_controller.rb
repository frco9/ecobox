class UsersController < ApplicationController
	before_action :signed_in_user, only: [:show]
	layout "login", :only => [:new]

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to Ecobox #{@user.name}";
			redirect_to @user
		else
			render 'new', layout: "login";
		end
	end

	private
		def user_params
			params.require(:user).permit(:firstname, :name, :email, :password, :password_confirmation)    
		end
end
