module HomeHelper

      # Structure to stock every statistics by type
      DailyStats = Struct.new(:typename, :min, :max, :avg, :curin, :curout)
      # Structure to stock statistics of the consommation (need less datas than DailyStats)
      ConsoStats = Struct.new(:min, :max, :cur, :cum)
      # Get unavailable sensors
      def unavailable_sensors
            sensors_tab = []
            sensors = Sensor.all
            sensors.each do |sensor|
                 # Get the last data for each sensor and check the datetime of its creation
                 datas = sensor.data_sensors.last
	               # If a sensor have not sent a data within 10 min, It is considerated unavailable 
                 if !datas or datas.created_at < 10.minutes.ago
                     if(sensor.room_id and !sensor.name.empty?)
                         sensors_tab << sensor
                     end
                 end
            end
            return sensors_tab
      end

      # Get new sensors
      def new_sensors
            sensors_tab = []
            sensors = Sensor.all
            sensors.each do |sensor|
                 # New sensors detection is based on empty names
                 if !sensor.name or sensor.name.empty?
                     sensors_tab << sensor
                 end
            end
            return sensors_tab
      end
    
      # Get temperature statistics
      def get_temp
          
          temps = []
          # Get statistics by areas:
          @areas.each do |area|
             # Get temperature datas for the given area from the beginning of the day to now
             req = DataSensor.where(:created_at => @begin..@time, :data_type_id => @temptype.id).joins(sensor: :room).where("rooms.area_id = ?",area.id)
             # Get outside temperature datas from 2 minutes to now
             ext = DataSensor.where(:created_at => 2.minutes.ago..@time, :data_type_id => @temptype.id).joins(sensor: :room).where("rooms.outside = ?",true)
             # Get others stats:
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
                  tmp = DailyStats.new(area.name,number_with_precision(min, :precision => 1),number_with_precision(max, :precision => 1),number_with_precision(avg, :precision => 1),number_with_precision(curin, :precision => 1),curout)
                  temps << tmp
              end
           end
           return temps
      end

      # Get consumption statistics
      def get_conso
          req = DataSensor.where(:created_at => @begin..@time, :data_type_id => @consotype.id)
          if !req.empty?
              min = req.order('value ASC').take!.value
              max = req.order('value DESC').take!.value
              cur = DataSensor.select('AVG(value) as value').where(:created_at => 2.minutes.ago..@time, :data_type_id => @consotype.id).take!.value    
              cum = DataSensor.select('SUM(value) as value').where(:created_at => @begin..@time, :data_type_id => @consotype.id).take!.value 
              tmp = ConsoStats.new(number_with_precision(min, :precision => 1),number_with_precision(max, :precision => 1),number_with_precision(cur, :precision => 1),number_with_precision(cum, :precision => 1))
           end
           return tmp
     end

      # Get other type statistics
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
                  tmp = DailyStats.new(data_type.name,number_with_precision(min, :precision => 1),number_with_precision(max, :precision => 1),number_with_precision(avg, :precision => 1),number_with_precision(curin, :precision => 1),curout)
                  stats << tmp
              end
           end
           return stats
     end

      
      
end
