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
       min = DataSensor.where(:created_at => @begin..@time, :data_type_id => data_type.id).order('value ASC').take!.value
       max = DataSensor.where(:created_at => @begin..@time, :data_type_id => data_type.id).order('value DESC').take!.value
       avg = DataSensor.select('AVG(value) as value').where(:created_at => @begin..@time, :data_type_id => data_type.id).take!.value 
       cur = DataSensor.select('AVG(value) as value').where(:created_at => 2.minutes.ago..@time, :data_type_id => data_type.id).take!.value 
       tmp = DailyStats.new(data_type.name,min,max,number_with_precision(avg, :precision => 2),number_with_precision(cur, :precision => 2))
       @stats << tmp
    end
   
    @unavailable_sensors =  unavailable_sensors
    @new_sensors =  new_sensors
   
  end       
end
