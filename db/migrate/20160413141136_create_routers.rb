class CreateRouters < ActiveRecord::Migration[5.0]
  def change
    create_table :routers do |t|
      t.string :ssid
      t.string :mac_address, unique: true

      t.timestamps
    end
  end
end
