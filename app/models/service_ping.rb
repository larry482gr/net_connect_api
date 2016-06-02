class ServicePing < ApplicationRecord
  belongs_to :user
  belongs_to :router
end
