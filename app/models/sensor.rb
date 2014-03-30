class Sensor < ActiveRecord::Base
  validates :name, uniqueness: { case_sensitive: false }
  validates :hardware_address, presence: true,
                              uniqueness: { case_sensitive: false }
  belongs_to :detail
  belongs_to :room
  has_many :sensors_data_types, :dependent => :delete_all
  has_many :data_sensors, :dependent => :delete_all
  has_many :data_types, :through => :sensors_data_types

end
