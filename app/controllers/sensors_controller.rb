class SensorsController < ApplicationController	
	before_action :signed_in_user
  before_action :set_sensor, only: [:show, :edit, :update, :destroy]

  # GET /sensors
  # GET /sensors.json
  def index
    @sensors = Sensor.all
  end

  # GET /sensors/1
  # GET /sensors/1.json
  def show
    Sensor.genSensorList(@sensor)
  end

  # GET /sensors/new
  def new
    @sensor = Sensor.new
  end

  # GET /sensors/1/edit
  def edit
  end

  def sensor_data
    @sensors = Sensor.find(params[:id].split(','))
    @start_date = DateTime.parse(params[:start_date]).to_s(:db)
    @end_date = DateTime.parse(params[:end_date]).to_s(:db)
    @selected_data = []
    @sensors.each do |sensor|
      @selected_data << sensor.data_sensors.where("created_at between '#{@start_date}' and '#{@end_date}'").order("created_at ASC")
    end 
    # @array_data = Sensor.genSensorList(@selected_data, @sensor)
  
    respond_to do |format|
      format.json
    end
  end

  # POST /sensors
  # POST /sensors.json
  def create
    @sensor = Sensor.new(sensor_params)

    respond_to do |format|
      if @sensor.save
        format.html { redirect_to @sensor, notice: 'Sensor was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sensor }
      else
        format.html { render action: 'new' }
        format.json { render json: @sensor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sensors/1
  # PATCH/PUT /sensors/1.json
  def update
    respond_to do |format|
      if @sensor.update(sensor_params)
        format.html { redirect_to @sensor, notice: 'Sensor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sensor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sensors/1
  # DELETE /sensors/1.json
  def destroy
    @sensor.destroy
    respond_to do |format|
      format.html { redirect_to sensors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensor
      @sensor = Sensor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sensor_params
      params.require(:sensor).permit(:frequency, :name, :modulation_id, :room_id)
    end
end
