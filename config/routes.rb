Rails.application.routes.draw do

  root "sessions#index"
  get '/how_to' => "sessions#how_to"
  get "/auth/:provider/callback" => "sessions#create"

  post "/create_avatar" => "users#create_avatar"
  post "/chatrooms" => "chatrooms#create"
  post "/messages" => "messages#create"
  get "/messages" => "messages#index"
  get "/chatrooms" => "chatrooms#index"
  get "/get_messages" => "chatrooms#get_messages"
  get "/chatrooms/search" => "chatrooms#search"
  get "/chatrooms/:name" => "chatrooms#show"
  get "/register" => "users#register"

	get "/signout" => "sessions#destroy"

end
