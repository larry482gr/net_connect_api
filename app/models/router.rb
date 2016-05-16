class Router < ApplicationRecord
  has_many :users

  validates_uniqueness_of :mac_address
end
