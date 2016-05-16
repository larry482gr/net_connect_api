class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :photo
      t.string :bg_photo
      t.string :about_me
      t.integer :age
      t.date :birthday
      t.string :gender

      t.timestamps
    end
  end
end
