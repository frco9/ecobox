class Room < ActiveRecord::Base
   has_many :sensors
   has_many :actuators
end
