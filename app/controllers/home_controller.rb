# -*- coding: utf-8 -*-
class HomeController < ApplicationController
    include ActionView::Helpers::NumberHelper
    include HomeHelper
	before_action :signed_in_user

# Main fonction of the Home page
  def index

    @time = Time.now
    @begin = @time.beginning_of_day

	# Getting unavailable sensors:
    @datatype = DataType.all
    
    @stats = []
    @datatype.each do |data_type|
       req = DataSensor.where(:created_at => @begin..@time, :data_type_id => data_type.id).joins(sensor: :room).where("rooms.outside = ?",false)
       ext = DataSensor.where(:created_at => 2.minutes.ago..@time, :data_type_id => data_type.id).joins(sensor: :room).where("rooms.outside = ?",true)
       if !req.empty?
           min = req.order('value ASC').take!.value
           max = req.order('value DESC').take!.value
           avg = DataSensor.select('AVG(value) as value').where(:created_at => @begin..@time, :data_type_id => data_type.id).joins(sensor: :room).where("rooms.outside = ?",false).take!.value 
           curin = DataSensor.select('AVG(value) as value').where(:created_at => 2.minutes.ago..@time, :data_type_id => data_type.id).joins(sensor: :room).where("rooms.outside = ?",false).take!.value 
           if !ext.empty?
               curout = ext.select('AVG(value) as value').take!.value
               curout = number_with_precision(curout, :precision => 2)
           else
               curout = "null"
           end  
           tmp = DailyStats.new(data_type.name,min,max,number_with_precision(avg, :precision => 2),number_with_precision(curin, :precision => 2),curout)
           @stats << tmp
       end
    end
   
    @unavailable_sensors =  unavailable_sensors
    @new_sensors =  new_sensors
   
  end       
end
