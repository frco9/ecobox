namespace :db do
  desc "Fill database with sample data"
  task fakedata: :environment do
    modulations = ["ASK", "FSK", "PSK"]
    data_types = ["Temperature", "Pression", "Hygrometrie", "Consommation"]
    rooms = ["Salon", "Cuisine", "Salle a manger", "Salle de bain", "Garage", "Chambre 1", "Chambre 2"]
    details = ["tx29", "pt1000", "tx3th", "t35dth-id"]


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

    Sensor.create!(hardware_address: Faker::Internet.ip_v6_address)

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

    100.times do |n|
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
    
  
    #Capteur interieur
    100.times do |n|
      sensor_id = Faker::Number.between(1,Sensor.all.length)
      created_at  = Faker::Time.between("01/03/2014", Time.new.strftime("%d/%m/%Y"))
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

    
    #Capteur exterieur
    modulation_id  = Faker::Number.between(1, modulations.length)
    room_id = Room.find_by(outside:true).try(:id)
    hardware_address = Faker::Internet.ip_v6_address
    detail_id  = Faker::Number.between(1, details.length)
    created_at  = Time.new.to_s(:db)
    Sensor.create!(name: "Capteur ext",
           hardware_address: hardware_address,  
                   room_id: room_id,
       detail_id: detail_id,
                   created_at: created_at,
                   updated_at: created_at)
    
    SensorsDataType.create!(sensor_id: Sensor.last.id,
                  data_type_id: 1)
           
    100.times do |n|
      value = Faker::Number.between(-10, 25)
      data_type_id = 1
      sensor_id = Sensor.last.id
      created_at  = Faker::Time.between("01/03/2014", Time.new.strftime("%d/%m/%Y"))
      DataSensor.create!(value: value,
                   sensor_id: sensor_id,
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
    
  end
end
