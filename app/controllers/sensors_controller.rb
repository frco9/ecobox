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
    end
  end

  # GET /sensors/list
  def list
    @sensors = Sensor.all
    #We set as max end_date the minimum of the last data from each sensors
    @maxDate = Sensor.all.map { |sensor| sensor.data_sensors.order("created_at").last[:created_at]}.min
    #We set as min start_date the maximum of the first data from each sensors
    @minDate = Sensor.all.map { |sensor| sensor.data_sensors.order("created_at").first[:created_at]}.max
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
  end

  def active_sensor
    render :nothing => true

    @sensors = Sensor.find(params[:id].split(','))
    if Sensor.where(:is_activated => true).count() == 1 and !params[:is_activated]
      return
    end
    @sensors.each do |sensor|
      sensor.update(:is_activated => params[:is_activated])
    end
  end

  def sensor_data
    @sensors = Sensor.find(params[:id].split(','))
    @start_date = DateTime.parse(params[:startDate]).to_s(:db) if params[:startDate]
    @end_date = DateTime.parse(params[:endDate]).to_s(:db) if params[:endDate]
    points_frequency = params[:pointFrequency]
    valid_frequency = false
    valid_frequency = true if ["year", "month", "day", "hour", "minute", "second"].include? points_frequency
    @selected_data = []
    @sensors.each do |sensor|
      query = sensor.data_sensors
      query = query.select('round(AVG(value)::numeric,2) as value, sensor_id').group(:sensor_id) if valid_frequency
      query = query.select('*, created_at as date') unless valid_frequency
      query = query.where("created_at between '#{@start_date}' and '#{@end_date}'") if @start_date and @end_date
      query = query.count_by("created_at", :group_by => points_frequency, :group_column => "date") if valid_frequency
      query = query.order("date ASC")
      @selected_data << query
    end 
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
        format.html { redirect_to @sensor, flash: { info: "Sensor was successfully created."} }
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
        format.html { redirect_to @sensor, flash: { info: "Sensor was successfully updated." }}
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
      params.require(:sensor).permit(:frequency, :name, :modulation_id, :room_id)
    end
end
