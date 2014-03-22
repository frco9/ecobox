# -*- coding: utf-8 -*-
class HomeController < ApplicationController
    include ActionView::Helpers::NumberHelper
    include HomeHelper
	before_action :signed_in_user

# Main fonction of the Home page
  def index

    @time = Time.now
    @begin = @time.beginning_of_day
    @datatype = DataType.where("data_types.name != ? and data_types.name != ?","Temperature","Consommation")
    @areas = Area.all
    
    @consotype = DataType.where(:name => "Consommation").take!
    @temptype = DataType.where(:name => "Temperature").take!
    @stats = get_stats
    @conso = get_conso
    @temp = get_temp
    @unavailable_sensors =  unavailable_sensors
    @new_sensors =  new_sensors
    @requette = Sensor.where(:data_type => @temptype)
    
    logger.debug @requette
  end       
end
