Rails.application.routes.draw do
    resources :rooms
    resources :messages

  get "/chess" => "rooms#chess"
  get "/test" => "rooms#test"
  root 'rooms#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => "/cable"
end
