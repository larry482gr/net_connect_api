class DropLocalIpPortFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :local_ip
    remove_column :users, :local_port
    remove_column :users, :external_address
  end
end
