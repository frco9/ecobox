class Actuator < ActiveRecord::Base
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validates :frequency, presence: true
	validates :modulation_id, presence: true
	validates :room_id, presence: true

	belongs_to :modulation
	belongs_to :room
	has_many :actuators_data_types
	has_many :data_actuators
	has_many :data_types, :through => :actuators_data_types
end
