class User < ApplicationRecord
  include Tokenable

  reverse_geocoded_by :latitude, :longitude

  belongs_to :router, optional: true
  has_one :user_profile
  has_many :service_pings

  validates_uniqueness_of :api_token
  validates_uniqueness_of :fb_user_id
  validates_uniqueness_of :fb_access_token

  accepts_nested_attributes_for :router
  accepts_nested_attributes_for :user_profile
end
