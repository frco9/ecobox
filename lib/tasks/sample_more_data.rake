namespace :db do
  desc "Fill database with sample data"
  task addmore: :environment do
  
    5000.times do |n|
      sensor_id = Faker::Number.between(1,Sensor.all.length - 1)
      created_at  = Faker::Time.between(Time.now.beginning_of_day, Time.now.end_of_day)
      sensor_data_types = SensorsDataType.where(:sensor_id => sensor_id)
      sensor_data_types.each do |sensor_data_type|
            data_type_id = sensor_data_type.data_type_id
            case data_type_id
            when 1 
                 value = Faker::Number.between(18, 25)
            when 2
          	 value = Faker::Number.between(950, 1050)
            when 3
            	 value = Faker::Number.between(0, 100)
            else
                 value = Faker::Number.between(50, 300)
            end
            DataSensor.create!(value: value,
                      sensor_id: sensor_id,
                      data_type_id: data_type_id,
                      created_at: created_at,
                     updated_at: created_at)
       end	     
     end


    4000.times do |n|
      value = Faker::Number.between(-10, 25)
      data_type_id = 1
      sensor_id = Sensor.last.id
      created_at  = Faker::Time.between(Time.now.beginning_of_day, Time.now.end_of_day)
      DataSensor.create!(value: value,
                   sensor_id: sensor_id,
                   data_type_id: data_type_id,
                   created_at: created_at,
                   updated_at: created_at)
    end
    
  end
end