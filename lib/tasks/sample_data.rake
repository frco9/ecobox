namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    modulations = ["ASK", "FSK", "PSK"]
    data_types = ["Temperature", "Pression", "Hygrometrie", "Consommation"]
    rooms = ["Salon", "Cuisine", "Salle a manger", "Salle de bain", "Garage", "Chambre 1", "Chambre 2"]
    
    modulations.each do |mod|
      Modulation.create!(name: mod)
    end

    data_types.each do |type|
      DataType.create!(name: type)
    end

    rooms.each do |type|
      Room.create!(name: type)
    end

    10.times do |n|
      modulation_id  = Faker::Number.between(1, modulations.length)
      room_id = Faker::Number.between(1, rooms.length)
      created_at  = Faker::Date.between("01/01/2014", "02/02/2014")
      Sensor.create!(frequency: 868.3,
                   name: "Capteur #{n}",
                   modulation_id: modulation_id,
                   room_id: room_id,
                   created_at: created_at,
                   updated_at: created_at)
    end

    10.times do |n|
      data_type_id = Faker::Number.between(1, data_types.length)
      SensorsDataType.create!(sensor_id: n,
                   data_type_id: data_type_id)
    end

    3.times do |n|
      data_type_id = Faker::Number.between(1, data_types.length)
      sensor_id = Faker::Number.between(1, Sensor.all.length)
      SensorsDataType.create!(sensor_id: sensor_id,
                   data_type_id: data_type_id)
    end

    1000.times do |n|
      value = Faker::Number.between(5, 30)
      data_type_id = Faker::Number.between(1, DataType.all.length)
      sensor_id = Faker::Number.between(1, Sensor.all.length)
      created_at  = Faker::Date.between("01/01/2013", "02/02/2014")
      DataSensor.create!(value: value,
                   sensor_id: sensor_id,
                   data_type_id: data_type_id,
                   created_at: created_at,
                   updated_at: created_at)
    end


    # Password validation fails when populate
    # 
    # 2.times do |n|
    #   name = Faker::Name.last_name
    #   firstname = Faker::Name.first_name
    #   email = "user-#{n}@ecobox.com"
    #   created_at  = Faker::Date.between("01/01/2014", "02/02/2014")
    #   User.create!(name: name,
    #                firstname: firstname,
    #                email: email,
    #                created_at: created_at,
    #                updated_at: created_at,
    #                password_digest: Digest::SHA1.hexdigest("my_password"))
    # end

  end
end