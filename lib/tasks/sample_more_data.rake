namespace :db do
  desc "Fill database with sample data"
  task addmore: :environment do

    500.times do |n|
      value = Faker::Number.between(5, 30)
      data_type_id = Faker::Number.between(1, DataType.all.length)
      sensor_id = Faker::Number.between(1, Sensor.all.length)
      # created_at  = Faker::Time.between(Time.now.beginning_of_day, Time.now.end_of_day)
      created_at  = Faker::Time.between("10/03/2014", "15/03/2014")
      DataSensor.create!(value: value,
                   sensor_id: sensor_id,
                   data_type_id: data_type_id,
                   created_at: created_at,
                   updated_at: created_at)
    end
  end
end