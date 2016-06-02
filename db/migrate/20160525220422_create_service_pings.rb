class CreateServicePings < ActiveRecord::Migration[5.0]
  def change
    create_table :service_pings do |t|
      t.references :user, foreign_key: true
      t.references :router, foreign_key: true
      t.string :connection_instance
      t.timestamp :created_at
    end
  end
end
