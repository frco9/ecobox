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

    #SENSORS
    10.times do |n|
      modulation_id  = Faker::Number.between(1, modulations.length)
      room_id = Faker::Number.between(1, rooms.length)
      created_at  = Time.new.to_s(:db)
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

    
    #AJOUT ADMIN ET AUTRES UTILISATEURS
    User.create!(name: 'Admin',
              firstname: 'Trent',
              email: 'admin@gmail.com',
              password: 'foobar',
              password_confirmation: 'foobar',
              admin: true)
    10.times do |n|
      name = Faker::Name.last_name
      firstname = Faker::Name.first_name
      email = "user-#{n}@ecobox.com"
      password = "password"
      User.create!(name: name,
             firstname: firstname,
             email: email,
             password: password,
             password_confirmation: password)
    end

    #Capteur garage
    1000.times do |n|
      value = Faker::Number.between(5, 10)
      data_type_id = Faker::Number.between(1, DataType.all.length)
      sensor_id = 1
      created_at  = Faker::Time.between("01/01/2013", Time.new.strftime("%d/%m/%Y"))
      DataSensor.create!(value: value,
                   sensor_id: sensor_id,
                   data_type_id: data_type_id,
                   created_at: created_at,
                   updated_at: created_at)
    end

    #Capteur exterieur
    1000.times do |n|
      value = Faker::Number.between(2, 20)
      data_type_id = Faker::Number.between(1, DataType.all.length)
      sensor_id = 2
      created_at  = Faker::Time.between("01/01/2013", Time.new.strftime("%d/%m/%Y"))
      DataSensor.create!(value: value,
                   sensor_id: sensor_id,
                   data_type_id: data_type_id,
                   created_at: created_at,
                   updated_at: created_at)
    end

    #Capteur interieur
    5000.times do |n|
      value = Faker::Number.between(18, 25)
      data_type_id = Faker::Number.between(1, DataType.all.length)
      sensor_id = Faker::Number.between(3, Sensor.all.length)
      created_at  = Faker::Time.between("01/01/2013", Time.new.strftime("%d/%m/%Y"))
      DataSensor.create!(value: value,
                   sensor_id: sensor_id,
                   data_type_id: data_type_id,
                   created_at: created_at,
                   updated_at: created_at)
    end


    #ACTUATORS
    10.times do |n|
      modulation_id  = Faker::Number.between(1, modulations.length)
      room_id = Faker::Number.between(1, rooms.length)
      created_at  = Faker::Date.between("01/01/2014", "02/02/2014")
    rand_boolean = [true, false].sample
      Actuator.create!(frequency: 868.3,
                   name: "Actionneur #{n}",
                   modulation_id: modulation_id,
                   room_id: room_id,
           activated: rand_boolean,
                   created_at: created_at,
                   updated_at: created_at)
    end

    10.times do |n|
      data_type_id = Faker::Number.between(1, data_types.length)
      ActuatorsDataType.create!(actuator_id: n,
                   data_type_id: data_type_id)
    end

    3.times do |n|
      data_type_id = Faker::Number.between(1, data_types.length)
      actuator_id = Faker::Number.between(1, Actuator.all.length)
      ActuatorsDataType.create!(actuator_id: actuator_id,
                   data_type_id: data_type_id)
    end

    1000.times do |n|
      value = Faker::Number.between(5, 30)
      data_type_id = Faker::Number.between(1, DataType.all.length)
      actuator_id= Faker::Number.between(1, Actuator.all.length)
      created_at  = Faker::Date.between("01/01/2013", "02/02/2014")
      DataActuator.create!(value: value,
                   actuator_id: actuator_id,
                   data_type_id: data_type_id,
                   created_at: created_at,
                   updated_at: created_at)
    end
  end
end