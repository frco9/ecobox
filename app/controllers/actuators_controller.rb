class ActuatorsController < ApplicationController
	#contraintes sur les méthodes
	before_action :signed_in_user
	before_action :set_actuator, only: [:show, :edit, :update, :destroy]
	before_action :admin_user, only: [:destroy]

	def new
		@actuator = Actuator.new
	end

	def show
		#selon la requête http, transmet à une vue différente
		respond_to do |format|
	      format.html # show.html.erb
	      format.js   # show.js.erb
    	end
	end

	def edit
	end

	#index permet la récupération de la liste des actionneurs pour les transmettre à la vue index.html.erb correspondante
	def index
		@actuators = Actuator.all		 
	end

	def create
		@actuator = Actuator.new(actuator_params)

		if @actuator.save
			flash[:success] = "L'actionneur #{@actuator.name} a bien été ajouté";
			redirect_to actuators_url 
		else
			render 'new'
		end
	end

	def update
		if @actuator.update_attributes(actuator_params)
			flash[:success] = "Mise à jour de l'actionneur effectuée !"
			redirect_to @actuator
		else
			render 'edit'
		end	
	end

	def destroy
		@actuator.destroy
		respond_to do |format|
	      format.js 
	      format.html { redirect_to actuators_url }
    	end
	end

	private
		def set_actuator
			@actuator = Actuator.find(params[:id])
		end

		# actuator_params spécifie les attributs qui peuvent êtres mis a jour (pour la méthode update par exemple)
		def actuator_params
		  params.require(:actuator).permit(:name, :room_id, :detail_id, :activated, :data_type_ids =>[])
		end
		
		def admin_user
			redirect_to(root_url) unless current_user.admin?
		end
end
