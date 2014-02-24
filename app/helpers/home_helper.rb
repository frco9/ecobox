module HomeHelper

      def max(tab)
            maximum = tab[0]
            tab.each do |float|
                  if float > maximum
                      maximum = float
                  end
            end
            return maximum
      end
 
      def min(tab)
            minimum = tab[0]
            tab.each do |float|
                  if float < minimum
                      minimum = float
                  end
            end
            return minimum
      end

      def average(tab)
            sum = 0
            tab.each do |float|
                 sum += float
            end
            avg = sum/tab.size
            return avg
      end

end
