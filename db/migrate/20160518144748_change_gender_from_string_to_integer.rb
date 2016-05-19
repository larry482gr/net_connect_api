class ChangeGenderFromStringToInteger < ActiveRecord::Migration[5.0]
  def change
    change_column :user_profiles, :gender,  :integer, :limit => 1, :default => 0
  end
end
