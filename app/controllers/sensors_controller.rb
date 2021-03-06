# coding: utf-8
class SensorsController < ApplicationController	
	before_action :signed_in_user
  before_action :set_sensor, only: [:show, :edit, :blacklist_sensor, :update, :destroy]

  # GET /sensors
  # GET /sensors.json
  def index
  end

  # GET /sensors/1
  # GET /sensors/1.json
  def show
    # Get id parameters
    @sensors = Sensor.find(params[:id].split(','))
    #Little hack : when many ids are given, only the first is shown for html response format.
    @sensor = @sensors[0]
    respond_to do |format|
      format.html # show.html.erb
      format.json  # show.json.jbuilder
      format.js   # show.js.erb
    end
  end

  # GET /sensors/list
  def list
    # We check there's at least one sensor activated
    # otherwise we set one randomly
    if SensorsDataType.where(:is_activated => true).count() == 0
      random = SensorsDataType.all.shuffle.first
      SensorsDataType.where(sensor_id: random.try(:sensor_id), data_type_id: random.try(:data_type_id)).update_all(:is_activated => true)
    end
    
    # We select all sensors with a left outer join on data_type to get all possible associations
    @sensors = Sensor.joins(:data_types).select('sensors.*, data_types.id as data_type_id')
    # We set as max end_date the last data for each sensors
    @maxDate = @sensors.map { |sensor| sensor.data_sensors.select(:created_at).order(:created_at).last.try(:created_at)}
    # We set as min start_date the first data for each sensors
    @minDate = @sensors.map { |sensor| sensor.data_sensors.select(:created_at).order(:created_at).first.try(:created_at)}
    # We set min value for each sensors
    @minValue = @sensors.map { |sensor| sensor.data_sensors.select(:value).order(:value).first.try(:value)}
    # We set max value for each sensors
    @maxValue = @sensors.map { |sensor| sensor.data_sensors.select(:value).order(:value).last.try(:value)}

    # All sensors without left outer join
    @uniq_sensors = Sensor.all
    respond_to do |format|
      format.html # list.html.erb
      format.json  # list.json.jbuilder
    end
  end
  
  # GET /sensors/new
  # Unused to meet client expectations
  # def new
  #   @sensor = Sensor.new
  # end

  # GET /sensors/1/blacklist
  def blacklist_sensor
    # Sensor and all its datas are erased
    @sensor.destroy
    respond_to do |format|
      # Add sensor to the blacklist with its hardware adress
      if Blacklist.find_or_create_by(hardware_address: @sensor.try(:hardware_address))
        format.html { redirect_to sensors_list_path, flash: { warning: "Blacklistage du capteur réalisé avec succès."} }
      else
        format.html { redirect_to sensors_list_path, flash: { danger: "Une erreur s'est produite lors du blacklistage du capteur."} }
      end
    end
  end

  # GET /sensors/1/edit
  def edit
  end

  def active_sensor
    render :nothing => true

    # We don't desactivate sensor if any other sensor is enable.
    if SensorsDataType.where(:is_activated => true).count() == 1 and !params[:is_activated]
      return
    end
    # param id format : 1-1,2-1,3-2 => "sensor_id"-"data_type_id","sensor_id"-"data_type_id",....
    # Set sensor status to param is_activated
    params[:id].split(",").map do |i|
      SensorsDataType.where(sensor_id: i.split("-")[0], data_type_id: i.split("-")[1]).update_all(:is_activated => params[:is_activated])
    end
  end

  def sensor_data
    # Get post parameters and asign them to variables
    @start_date = DateTime.parse(params[:startDate]).to_s(:db) if params[:startDate]
    @end_date = DateTime.parse(params[:endDate]).to_s(:db) if params[:endDate]
    points_frequency = params[:pointFrequency]
    valid_frequency = false
    valid_frequency = true if ["year", "month", "day", "hour", "minute", "second"].include? points_frequency
    @selected_data = Array.new
    @ids = Array.new
    @data_type_ids = Array.new
    params[:id].split(",").map do |i|
      # Create custom query depending on params given
      query = Sensor.find(i.split("-")[0]).data_sensors
      query = query.where(:data_type_id => i.split("-")[1])
      query = query.select('round(AVG(value)::numeric,2) as value, sensor_id, data_type_id').group(:sensor_id, :data_type_id) if valid_frequency
      query = query.select('*, created_at as date') unless valid_frequency
      query = query.where(:created_at => @start_date..@end_date) if @start_date and @end_date
      query = query.count_by("created_at", :group_by => points_frequency, :group_column => "date") if valid_frequency
      query = query.order("date ASC")
      @selected_data << query
      @ids << i.split("-")[0]
      @data_type_ids << i.split("-")[1]
    end
    # If there is any data in the required time interval, we get the last point date,
    # and assign it to empty series (cf:sensor_data.json.jbuild)
    @maxDate = (@selected_data.map do |data|
      if data.last
        data.last.date.to_i
      else
        0
      end
    end).max
    respond_to do |format|
      format.json
    end
  end

  # POST /sensors
  # POST /sensors.json
  # Unused to meet client expectations
  # def create
  #   @sensor = Sensor.new(sensor_params)
  #   respond_to do |format|
  #     if @sensor.save
  #       format.html { redirect_to @sensor, flash: { success: "Ajout du capteur réalisé avec succès."} }
  #       format.json { render action: 'show', status: :created, location: @sensor }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @sensor.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /sensors/1
  # PATCH/PUT /sensors/1.json
  def update
    respond_to do |format|
      if @sensor.update(sensor_params)
        format.html { redirect_to sensors_list_path, flash: { success: "Enregistrement des informations réalisé avec succès." }}
      else
        format.html { redirect_to sensors_list_path, flash: { danger: "Une erreur s'est produite lors de la mise à jour des informations."} }
      end
    end
  end

  # DELETE /sensors/1
  # DELETE /sensors/1.json
  def destroy
    @sensor.destroy
    respond_to do |format|
      format.js 
      format.html { redirect_to sensors_list_path }
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
      params.require(:sensor).permit(:name, :room_id, :detail_id, :data_type_ids =>[])
    end
end
