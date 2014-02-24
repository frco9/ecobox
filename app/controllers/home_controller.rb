# -*- coding: utf-8 -*-
class HomeController < ApplicationController
  
# Main fonction of the Home page
  def index

# Getting of all rooms:
    @rooms = Room.all
 
<<<<<<< HEAD
# Getting of the last value for each sensors: 
# => pb pour capteur a plusieurs types de donnees
    @sensors = Sensor.all
    @lastdatas = []
        
    @sensors.each do |sensor|    
        @lastdatas << sensor.data_sensors.last
=======
# Recuperation Des capteurs de types 
    @data_types = DataType.where(["name = 'Temperature'"])
    tmp = Time.now
#    time_of_availability = Time.new(tmp.year,tmp.month,tmp.day,tmp.hour,tmp.min- 2,tmp.sec)
    @last_data = DataSensor.last
    if @last_data != nil
       #@current_temperatures = @last_data.where("data_type = ?",@data_types)
>>>>>>> f85e53b011dc229623739edb6a3eba0ead941e84
    end
# Getting of types:

    @temp_type = DataType.find_by_name('Temperature')
    @press_type = DataType.find_by_name('Pression')

# Getting of values 
    @temperature_datas = []
    @pression_datas = []
    
    @lastdatas.each do |data_sensor|
       if data_sensor.data_type == @temp_type
           @temperature_datas << data_sensor 
       else 
           if data_sensor.data_type == @press_type
              @pression_datas << data_sensor
           end
       end 
    end 
   

    if !@temperature_datas.empty?
        @current_temp = 0.0
        nb_data = 0.0
        @temperature_datas.each do |data_sensor|
           #if data_sensor.created_at >= time_of_availability
           @current_temp += data_sensor.value
           nb_data += 1.0
           #end
        end
        @current_temp = @current_temp/nb_data
    else 
        @current_temp = 9999
    logger.debug @current_temp
    end
  end       
end
