namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    modulations = ["ASK", "FSK", "PSK"]
    data_types = ["Temperature", "Pression", "Hygrometrie", "Consommation"]
    data_render = ["line", "line", "bar", "bar"]
    rooms = ["Salon", "Cuisine", "Salle a manger", "Salle de bain", "Garage", "Chambre 1", "Chambre 2"]
    details = ["tx29", "pt1000", "tx3th", "t35dth-id"]
    areas = ["zone de jour", "zone de nuit", "zone mixte"]    

    modulations.each do |mod|
      Modulation.create!(name: mod)
    end

    data_types.each do |type|
      DataType.create!(name: type, graph_render: data_render.shift)
    end
    
    areas.each do |type|
       Area.create!(name: type)
    end
    
    rooms.each do |type|
      if (type == "Salon") or (type == "Cuisine") or (type == "Salle a manger")
          Room.create!(name: type, outside: false, area_id: 1)
      elsif (type == "Chambre 1") or (type == "Chambre 2")
          Room.create!(name: type, outside: false, area_id: 2)
      else
          Room.create!(name: type, outside: false, area_id: 3)
      end
    end

    #DETAILS
    details.each do |name|
      modulation_id = Faker::Number.between(1, modulations.length)
      Detail.create!(name: name,
                    frequency: 868.3,
                    modulation_id: modulation_id)
    end

    
    #Capteur exterieur
    Room.create!(name: "Exterieur", outside: true)

  
    
    
    
  end
end
