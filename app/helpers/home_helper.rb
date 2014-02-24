module HomeHelper

      def max(tab)
            if !tab.empty?
               maximum = tab[0]
               tab.each do |float|
                     if float > maximum
                        maximum = float
                    end
               end
               return maximum
            else
               return "Unavailable"
            end
      end
 
      def min(tab)
           if !tab.empty?
              minimum = tab[0]
              tab.each do |float|
                    if float < minimum
                        minimum = float
                    end
              end
              return minimum
           else
              return "Unavailable"
           end
      end

      def average(tab)
            if !tab.empty?
               sum = 0
               tab.each do |float|
                    sum += float
               end
               avg = sum/tab.length
               return avg
            else
               return 9999
            end
      end

      def unavailable_sensors
            sensors_tab = []
            tmp = Time.now
            time_of_availability = Time.new(tmp.year,tmp.month,tmp.day,tmp.hour,tmp.min - 2,tmp.sec)
            
            @sensors.each do |sensor|
                 datas = sensor.data_sensors.last
                 if datas.created_at < time_of_availability
                     sensors_tab << sensor
                 end
            end
            return sensors_tab
      end

end
