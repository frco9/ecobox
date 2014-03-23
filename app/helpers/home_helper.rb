module HomeHelper

      DailyStats = Struct.new(:typename, :min, :max, :avg, :curin, :curout)
      ConsoStats = Struct.new(:min, :max, :cur, :cum)
      def unavailable_sensors
            sensors_tab = []
            sensors = Sensor.all
            sensors.each do |sensor|
                 datas = sensor.data_sensors.last
	# If a sensor have not sent a data from 10 min, It is considerate as unavailable 
                 if !datas or datas.created_at < 10.minutes.ago
                     if(sensor.room_id and !sensor.name.empty?)
                         sensors_tab << sensor
                     end
                 end
            end
            return sensors_tab
      end

      def new_sensors
            sensors_tab = []
            sensors = Sensor.all
            sensors.each do |sensor|
                 if !sensor.name or sensor.name.empty?
                     sensors_tab << sensor
                 end
            end
            return sensors_tab
      end
     
      def get_temp
          
          temps = []
          @areas.each do |area|
             req = DataSensor.where(:created_at => @begin..@time, :data_type_id => @temptype.id).joins(sensor: :room).where("rooms.area_id = ?",area.id)
             ext = DataSensor.where(:created_at => 2.minutes.ago..@time, :data_type_id => @temptype.id).joins(sensor: :room).where("rooms.outside = ?",true)
             if !req.empty?
                 min = req.order('value ASC').take!.value
                 max = req.order('value DESC').take!.value
                 avg = DataSensor.select('AVG(value) as value').where(:created_at => @begin..@time, :data_type_id => @temptype.id).joins(sensor: :room).where("rooms.area_id = ?",area.id).take!.value 
                 curin = DataSensor.select('AVG(value) as value').where(:created_at => 2.minutes.ago..@time, :data_type_id => @temptype.id).joins(sensor: :room).where("rooms.area_id = ?",area.id).take!.value 
                  if !ext.empty?
                      curout = ext.select('AVG(value) as value').take!.value
                      curout = number_with_precision(curout, :precision => 1)
                  else
                      curout = "null"
                  end  
                  tmp = DailyStats.new(area.name,min,max,number_with_precision(avg, :precision => 1),number_with_precision(curin, :precision => 1),curout)
                  temps << tmp
              end
           end
           return temps
      end


      def get_conso
          req = DataSensor.where(:created_at => @begin..@time, :data_type_id => @consotype.id)
          if !req.empty?
              min = req.order('value ASC').take!.value
              max = req.order('value DESC').take!.value
              cur = DataSensor.select('AVG(value) as value').where(:created_at => 2.minutes.ago..@time, :data_type_id => @consotype.id).take!.value    
              cum = DataSensor.select('SUM(value) as value').where(:created_at => @begin..@time, :data_type_id => @consotype.id).take!.value 
              tmp = ConsoStats.new(min,max,number_with_precision(cur, :precision => 1),number_with_precision(cum, :precision => 1))
           end
           return tmp
     end


      def get_stats
          stats = []
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
                      curout = number_with_precision(curout, :precision => 1)
                  else
                      curout = "null"
                  end  
                  tmp = DailyStats.new(data_type.name,min,max,number_with_precision(avg, :precision => 1),number_with_precision(curin, :precision => 1),curout)
                  stats << tmp
              end
           end
           return stats
     end

      
      
end
