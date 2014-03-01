class Actuator < ActiveRecord::Base
	validates :name, presence: true
	validates :frequency, presence: true
	validates :modulation_id, presence: true
	validates :room_id, presence: true

	belongs_to :modulation
	belongs_to :room
	has_many :data_actuators
	has_many :data_types, :through => :actuators_data_types
end
