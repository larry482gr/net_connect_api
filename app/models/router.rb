class Router < ApplicationRecord
  has_many :users
  has_many :service_pings

  validates_uniqueness_of :mac_address
end
