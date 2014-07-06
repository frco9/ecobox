class Actuator < ActiveRecord::Base
	validates :name, uniqueness: { case_sensitive: false }
	validates :hardware_address, presence: true, 
								uniqueness: { case_sensitive: false }
	belongs_to :detail
	belongs_to :room
	has_many :actuators_data_types
	has_many :data_actuators
	has_many :data_types, :through => :actuators_data_types
end
