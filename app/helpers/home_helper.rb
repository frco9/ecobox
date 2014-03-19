module HomeHelper

      DailyStats = Struct.new(:typename, :min, :max, :avg, :curin, :curout)
     
      def unavailable_sensors
            sensors_tab = []
            sensors = Sensor.all
            sensors.each do |sensor|
                 datas = sensor.data_sensors.last
	# If a sensor have not sent a data from 2 min, It is considerate as unavailable 
                 if !datas or datas.created_at < 2.minutes.ago
                     sensors_tab << sensor
                 end
            end
            return sensors_tab
      end

      def new_sensors
            sensors_tab = []
            sensors = Sensor.all
            sensors.each do |sensor|
                 if sensor.name.empty?
                     sensors_tab << sensor
                 end
            end
            return sensors_tab
      end
end
