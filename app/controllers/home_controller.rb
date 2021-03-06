# -*- coding: utf-8 -*-
class HomeController < ApplicationController
    include ActionView::Helpers::NumberHelper
    include HomeHelper
	before_action :signed_in_user

# Home page main function
  def index

    @time = Time.now
    @begin = @time.beginning_of_day
    @areas = Area.all
    #Get the data types which are not a consommation or a temperature:
    @datatype = DataType.where("data_types.name != ? and data_types.name != ?","Temperature","Consommation")
    @consotype = DataType.where(:name => "Consommation").take!
    @temptype = DataType.where(:name => "Temperature").take!
    
    # Get temperature and consumption statistics:
    @temp = get_temp
    @conso = get_conso    
    # Get others types statistics:
    @stats = get_stats
    # Get unavailable sensors:
    @unavailable_sensors = unavailable_sensors
    # Get new sensors:
    @new_sensors =  new_sensors
  end       
end
