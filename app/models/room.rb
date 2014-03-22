class Room < ActiveRecord::Base
   has_many :sensors
   has_many :actuators
   belongs_to :area
end
