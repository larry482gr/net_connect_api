Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  #constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        resources :users do
          get :current_network_users, as: :current_network_users, on: :member
          # get 'current_network_users/:ssid/:mac_address' => 'users#current_network_users', on: :member
        end
        get 'users/unregistered_network_users/:ssid/:mac_address' => 'users#unregistered_network_users', as: :unregistered_network_users
      end
    end
  #end
end
