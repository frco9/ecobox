# -*- coding: utf-8 -*-
class HomeController < ApplicationController
  
# Fonction Principale de la page Home
  def index
# Recuperation de toutes les pieces:
    @rooms = Room.all
 
# Recuperation Des capteurs de types 
    @data_types = DataType.where(["name = 'Temperature'"])
    tmp = Time.now
#    time_of_availability = Time.new(tmp.year,tmp.month,tmp.day,tmp.hour,tmp.min- 2,tmp.sec)
    @last_data = DataSensor.last
    if @last_data != nil
       @current_temperatures = @last_data.where("data_type = ?",@data_types)
    end

    if @current_temperatures != nil
        @current_temp = 0.0
        nb_data = 0.0
        @current_temperatures.each do |data_sensor|
           @current_temp += data_sensor.value
           nb_data += 1.0
        end
        @current_temp = @current_temp/nb_data
     else 
        @current_temp = 9999
    end
  end
end
