module HomeHelper

      def max(tab)
            if !tab.empty?
               maximum = tab[0].value
               tab.each do |data_sensor|
                     if data_sensor.value > maximum
                        maximum = data_sensor.value
                    end
               end
               return maximum
            else
               return "Unavailable"
            end
      end
 
      def min(tab)
           if !tab.empty?
              minimum = tab[0].value
              tab.each do |data_sensor|
                    if data_sensor.value < minimum
                        minimum = data_sensor.value
                    end
              end
              return minimum
           else
              return "Unavailable"
           end
      end

      def average(tab)
            if !tab.empty?
               sum = 0.0
               tab.each do |data_sensor|
                    sum += data_sensor.value
               end
               avg = sum/tab.length
               return avg
            else
               return "Unavailable"
            end
      end


      def current_value(type_data)
            datas = []
            @sensors.each do |sensor|
                data = sensor.data_sensors.last
# Use of datas from the 1-2 last minutes 
                if data.data_type == type_data and data.created_at.beginning_of_minute >= Time.new(@tmp.year,@tmp.month,@tmp.day,@tmp.hour,@tmp.min - 1,0)
                   datas << data
               end
            end
           
            if !datas.empty?
               tmp = 0.0
               datas.each do |data_sensor|
                   tmp += data_sensor.value
               end
               return tmp/datas.length
            else
               return "Unavailable"
            end
      end


      def unavailable_sensors
            sensors_tab = []
            
# If a sensor have not sent a data from 2 min, It is considerate as unavailable 
            time_of_availability = Time.new(@tmp.year,@tmp.month,@tmp.day,@tmp.hour,@tmp.min - 2,@tmp.sec)
            
            @sensors.each do |sensor|
                 datas = sensor.data_sensors.last
                 if datas.created_at < time_of_availability
                     sensors_tab << sensor
                 end
            end
            return sensors_tab
      end
end
