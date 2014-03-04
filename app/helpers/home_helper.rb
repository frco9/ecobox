module HomeHelper

      DailyStats = Struct.new(:typename, :min, :max, :avg, :current)
     
      def unavailable_sensors
            sensors_tab = []
            sensors = Sensor.all
# If a sensor have not sent a data from 2 min, It is considerate as unavailable 
            time_of_availability = 2.minutes.ago
            
            sensors.each do |sensor|
                 datas = sensor.data_sensors.last
                 if datas.created_at < time_of_availability
                     sensors_tab << sensor
                 end
            end
            return sensors_tab
      end
end
