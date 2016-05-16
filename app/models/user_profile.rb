class UserProfile < ApplicationRecord
  belongs_to :user, touch: true
end
