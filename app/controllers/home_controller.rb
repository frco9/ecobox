# -*- coding: utf-8 -*-
class HomeController < ApplicationController
  include HomeHelper
# Main fonction of the Home page
  def index
#Getting the datetime:

    @tmp = Time.now

# Getting of the last value for each sensors: 
# => pb pour capteur a plusieurs types de donnees
    @sensors = Sensor.all

# Getting of types:
    @temp_type = DataType.find_by_name('Temperature')
    @press_type = DataType.find_by_name('Pression')


# Gettig of the daily datas by a generical way to have all the daily datas sorted by their data_type:
# @type = DataType.all
# @dailydatas = []
#      @type.each do |data_type|
#            datas = data_type.data_sensors
#            datas.each do |data_sensor|
#                if data_sensor.created_at.beginning_of_day ==  @tmp.beginning_of_day
#                    tmp << data_sensor
#                end
#            end
#            @dailydatas << tmp
#      end

    
# Getting of the daily datas:      
    @dailydatas = []
    @sensors.each do |sensor|
          datas = sensor.data_sensors
          datas.each do |data_sensor|
              if data_sensor.created_at.beginning_of_day ==  Time.now.beginning_of_day
                  @dailydatas << data_sensor
              end
          end
    end

logger.debug @dailydatas

# Separation of datas by type: 
   @temperature_datas = []
   @pressure_datas = []
    
   @dailydatas.each do |data_sensor|          
       if data_sensor.data_type == @temp_type
           @temperature_datas << data_sensor 
       else 
           if data_sensor.data_type == @press_type
              @pressure_datas << data_sensor
           end
       end
   end 
   

# Getting daily temperature statistics:
    @min_temp = min(@temperature_datas)
    @max_temp = max(@temperature_datas)
    @avg_temp = average(@temperature_datas)
    @current_temp = current_value(@temp_type)

# Getting daily temperature statistics:
    @min_press = min(@pressure_datas)
    @max_press = max(@pressure_datas)
    @avg_press = average(@pressure_datas)
    @current_press = current_value(@press_type)


# Getting unavailable sensors:

    @unavailable_sensors = unavailable_sensors
   
  end       
end
