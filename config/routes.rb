Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  #constraints subdomain: 'api' do
    scope module: 'api' do
        namespace :v1 do
          resources :users, except: [:index, :update, :destroy]
          resource :users, only: [:update, :destroy] do
            post :service_ping
          end
          get 'nearby_users' => 'users#nearby_users', as: :nearby_users
          get 'unregistered_nearby_users/:ssid/:mac_address' => 'users#unregistered_nearby_users', as: :unregistered_nearby_users
        end
    end
  #end
end
