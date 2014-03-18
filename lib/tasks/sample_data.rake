namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    modulations = ["ASK", "FSK", "PSK"]
    data_types = ["Temperature", "Pression", "Hygrometrie", "Consommation"]
    data_render = ["line", "line", "bar", "bar"]
    rooms = ["Salon", "Cuisine", "Salle a manger", "Salle de bain", "Garage", "Chambre 1", "Chambre 2"]
    details = ["tx29", "pt1000", "tx3th", "t35dth-id"]
    
    modulations.each do |mod|
      Modulation.create!(name: mod)
    end

    data_types.each do |type|
      DataType.create!(name: type, graph_render: data_render.shift)
    end

    rooms.each do |type|
      Room.create!(name: type)
    end

    #DETAILS
    details.each do |name|
      modulation_id = Faker::Number.between(1, modulations.length)
      Detail.create!(name: name,
                    frequency: 868.3,
                    modulation_id: modulation_id
                    )
    end

    #SENSORS
    10.times do |n|
      detail_id  = Faker::Number.between(1, details.length)
      room_id = Faker::Number.between(1, rooms.length)
      hardware_address = Faker::Internet.ip_v6_address
      created_at  = Time.new.to_s(:db)
      Sensor.create!(name: "Capteur #{n}",
                   hardware_address: hardware_address,
                   room_id: room_id,
                   detail_id: detail_id,
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

    #ACTUATORS
    10.times do |n|
      detail_id  = Faker::Number.between(1, details.length)
      room_id = Faker::Number.between(1, rooms.length)
      hardware_address = Faker::Internet.ip_v6_address
      created_at  = Faker::Date.between("01/01/2014", "02/02/2014")
      rand_boolean = [true, false].sample
      Actuator.create!(name: "Actionneur #{n}",
                   hardware_address: hardware_address,
                   room_id: room_id,
                   detail_id: detail_id,
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
      created_at  = Faker::Date.between("01/01/2014", "02/04/2014")
      DataActuator.create!(value: value,
                   actuator_id: actuator_id,
                   data_type_id: data_type_id,
                   created_at: created_at,
                   updated_at: created_at)
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
    500.times do |n|
      value = Faker::Number.between(5, 10)
      data_type_id = Faker::Number.between(1, DataType.all.length)
      sensor_id = 1
      created_at  = Faker::Time.between("01/01/2014", Time.new.strftime("%d/%m/%Y"))
      DataSensor.create!(value: value,
                   sensor_id: sensor_id,
                   data_type_id: data_type_id,
                   created_at: created_at,
                   updated_at: created_at)
    end

    #Capteur exterieur
    500.times do |n|
      value = Faker::Number.between(2, 20)
      data_type_id = Faker::Number.between(1, DataType.all.length)
      sensor_id = 2
      created_at  = Faker::Time.between("01/01/2014", Time.new.strftime("%d/%m/%Y"))
      DataSensor.create!(value: value,
                   sensor_id: sensor_id,
                   data_type_id: data_type_id,
                   created_at: created_at,
                   updated_at: created_at)
    end

    #Capteur interieur
    2000.times do |n|
      value = Faker::Number.between(18, 25)
      data_type_id = Faker::Number.between(1, DataType.all.length)
      sensor_id = Faker::Number.between(3, Sensor.all.length)
      created_at  = Faker::Time.between("01/01/2014", Time.new.strftime("%d/%m/%Y"))
      DataSensor.create!(value: value,
                   sensor_id: sensor_id,
                   data_type_id: data_type_id,
                   created_at: created_at,
                   updated_at: created_at)
    end

  end
end
