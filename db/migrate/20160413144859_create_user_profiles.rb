class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :fb_link
      t.string :email
      t.string :picture
      t.string :gender
      t.integer :age_min
      t.integer :age_max
      t.string :bg_picture
      t.string :about_me
      t.date :birthday

      t.timestamps
    end
  end
end
