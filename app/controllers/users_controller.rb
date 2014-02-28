class UsersController < ApplicationController
	before_action :signed_in_user, only: [:show, :index, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: [:destroy]
	layout "login", :only => [:new, :edit]

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		if User.all.size > 0 and (!current_user or !current_user.admin?)
			redirect_to signin_path, flash: { danger: "Seul l'administrateur a le droit d'ajouter des utilisateurs" }
		end

		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if User.all.size == 0
			@user.admin = true;
		end	
		
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to Ecobox #{@user.name}";
			if @user.admin?
				flash[:success] = "Vous êtes administrateur";
			end
			redirect_to @user
		else
			render 'new', layout: "login";
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Mise a jour effectuée"
			redirect_to @user
		else
			render 'edit', layout: "login";
		end
	end
	
	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "Utilisateur supprimé"
		redirect_to users_url
	end

	private
		def user_params
			params.require(:user).permit(:firstname, :name, :email, :password, :password_confirmation)    
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_url) unless current_user.admin?
		end
end
