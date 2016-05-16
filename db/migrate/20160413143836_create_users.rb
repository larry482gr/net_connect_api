class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :fb_user_id
      t.string :fb_access_token
      t.references :router, foreign_key: true
      t.string :local_ip
      t.integer :local_port
      t.string :external_address
      t.decimal :latitude, precision: 18, scale: 15
      t.decimal :longitude, precision: 18, scale: 15

      t.timestamps
    end

    add_index :users, :fb_user_id, :unique => true
    add_index :users, :fb_access_token, :unique => true
  end
end
