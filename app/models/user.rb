class User < ApplicationRecord
  # include Tokenable

  belongs_to :router, optional: true
  has_one :user_profile

  accepts_nested_attributes_for :router
  accepts_nested_attributes_for :user_profile
end
