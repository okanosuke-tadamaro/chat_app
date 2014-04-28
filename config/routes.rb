Rails.application.routes.draw do

  root "sessions#index"
  get '/auth/:provider/callback' => "sessions#create"
  get "/signout" => "sessions#destroy"
  get "/chatrooms/:room_name" => "chatrooms#show"
  post "/chatrooms" => "chatrooms#create"
  post "/messages" => "messages#create"

end