Rails.application.routes.draw do

  # root "sessions#index"
  root "chatrooms#index"
  get '/auth/:provider/callback' => "sessions#create"
  get "/signout" => "sessions#destroy"

  post '/chatrooms' => 'chatrooms#create'

  get '/chatrooms/:name' => 'chatrooms#show'


end
