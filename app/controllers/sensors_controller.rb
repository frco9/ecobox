class SensorsController < ApplicationController	
	before_action :signed_in_user
  before_action :set_sensor, only: [:show, :edit, :update, :destroy]

  # GET /sensors
  # GET /sensors.json
  def index
  end

  # GET /sensors/1
  # GET /sensors/1.json
  def show
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
      SensorsDataType.where(sensor_id: random.sensor_id, data_type_id: random.data_type_id).update_all(:is_activated => true)
    end
    
    # We select all sensors with a left outer join on data_type to get all possible associations
    @sensors = Sensor.joins(:data_types).select('sensors.*, data_types.id as data_type_id')
    # We set as max end_date the last data for each sensors
    @maxDate = @sensors.map { |sensor| sensor.data_sensors.select(:created_at).order(:created_at).last}
    # We set as min start_date the first data for each sensors
    @minDate = @sensors.map { |sensor| sensor.data_sensors.select(:created_at).order(:created_at).first}

    # All sensors without left outer join
    @uniq_sensors = Sensor.all
    respond_to do |format|
      format.html # list.html.erb
      format.json  # list.json.jbuilder
    end

  end
  # GET /sensors/new
  def new
    @sensor = Sensor.new
  end

  # GET /sensors/1/edit
  def edit
    respond_to do |format|
      format.js   # edit.js.erb
    end
  end

  def active_sensor
    render :nothing => true

    # We don't desactivate sensor if any other sensor is enable.
    if SensorsDataType.where(:is_activated => true).count() == 1 and !params[:is_activated]
      return
    end

    params[:id].split(",").map do |i|
      SensorsDataType.where(sensor_id: i.split("-")[0], data_type_id: i.split("-")[1]).update_all(:is_activated => params[:is_activated])
    end
  end

  def sensor_data
    @start_date = DateTime.parse(params[:startDate]).to_s(:db) if params[:startDate]
    @end_date = DateTime.parse(params[:endDate]).to_s(:db) if params[:endDate]
    points_frequency = params[:pointFrequency]
    valid_frequency = false
    valid_frequency = true if ["year", "month", "day", "hour", "minute", "second"].include? points_frequency
    @selected_data = Array.new
    @ids = Array.new
    @data_type_ids = Array.new
    params[:id].split(",").map do |i|
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
  def create
    @sensor = Sensor.new(sensor_params)
    respond_to do |format|
      if @sensor.save
        format.html { redirect_to @sensor, flash: { success: "Sensor was successfully created."} }
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
        format.html { redirect_to @sensor, flash: { success: "Sensor was successfully updated." }}
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
      params.require(:sensor).permit(:frequency, :name, :modulation_id, :room_id, :data_type_ids =>[])
    end
end
