class UsersController < ApplicationController
  # Actions to execute before executing one of these methods
	before_action :signed_in_user, only: [:show, :index, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: [:destroy]

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
    # Check if user is admin and thus can create user account or if any admin was created. 
		if User.all.size == 0
			render 'new_admin', layout: "login"
		elsif signed_in? and current_user.admin?
			render 'new'
		else
			redirect_to signin_path, flash: { danger: "Seul l'administrateur a le droit d'ajouter des utilisateurs" }
		end
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
			render 'edit';
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

    # correct_user true if the current user match the one he is trying to access.
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_url) unless current_user.admin?
		end
end
