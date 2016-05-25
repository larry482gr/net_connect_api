class User < ApplicationRecord
  include Tokenable

  belongs_to :router, optional: true
  has_one :user_profile

  validates_uniqueness_of :api_token
  validates_uniqueness_of :fb_user_id
  validates_uniqueness_of :fb_access_token

  accepts_nested_attributes_for :router
  accepts_nested_attributes_for :user_profile
end
