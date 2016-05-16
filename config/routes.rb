Rails.application.routes.draw do
  resources :users do
    get :current_network_users, on: :member
  end
  get 'users/unregistered_network_users/:ssid/:mac_address' => 'users#unregistered_network_users', as: :unregistered_network_users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
