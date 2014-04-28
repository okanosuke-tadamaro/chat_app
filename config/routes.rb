Rails.application.routes.draw do

  root "sessions#index"
  get '/auth/:provider/callback' => "sessions#create"
  get "/signout" => "sessions#destroy"

  resources :chatrooms
  resources :messages

end
