Rails.application.routes.draw do
    resources :rooms
    resources :messages
    resources :users
  get "/chess" => "rooms#chess"
  root 'sessions#new'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  post 'join' => 'rooms#join'
  post 'exit' => 'rooms#exit'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => "/cable"
end
