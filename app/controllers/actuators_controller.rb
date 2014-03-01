class ActuatorsController < ApplicationController
	before_action :signed_in_user

	def new
		@actuator = Actuator.new
	end

	def show
	end

	def index
		@rooms = Room.all
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
	end

	def destroy
	end

	private
		# Never trust parameters from the scary internet, only allow the white list through.
		def actuator_params
		  params.require(:actuator).permit(:frequency, :name, :modulation_id, :room_id)
		end
end
