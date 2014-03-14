class ActuatorsController < ApplicationController
	before_action :signed_in_user
	before_action :set_actuator, only: [:show, :edit, :update, :destroy]
	before_action :admin_user, only: [:destroy]

	def new
		@actuator = Actuator.new
	end

	def show
		respond_to do |format|
	      format.html # show.html.erb
	      format.js   # show.js.erb
    	end
	end

	def edit
		respond_to do |format|
			format.js
		end	
	end

	def index
		@rooms = Room.all
		@actuators = Actuator.all		 
	end

	def create
		@actuator = Actuator.new(actuator_params)
		@actuator.update_attributes(id: params[:id])	
		@actuator.data_types << DataType.find(params[:actuators_data_types][:data_type_id]) if @actuator.id

		if @actuator.save
			flash[:success] = "L'actionneur #{@actuator.name} a bien été ajouté";
			redirect_to actuators_url 
		else
			render 'new'
		end
	end

	def update
		@actuator.data_types = Array.new
		@actuator.data_types << DataType.find(params[:actuators_data_types][:data_type_id])

		if @actuator.update_attributes(actuator_params)
			flash[:success] = "Mise à jour de l'actionneur effectuée !"
			redirect_to @actuator
		else
			render 'edit'
		end	
	end

	def destroy
		@actuator.destroy
		flash[:success] = "Actionneur supprimé !"
		redirect_to actuators_url
	end

	private
		def set_actuator
			@actuator = Actuator.find(params[:id])
		end

		def actuator_params
		  params.require(:actuator).permit(:frequency, :name, :modulation_id, :room_id, :activated, :data_types)
		end
		
		def admin_user
			redirect_to(root_url) unless current_user.admin?
		end
end
