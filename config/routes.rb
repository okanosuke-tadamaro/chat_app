Rails.application.routes.draw do

  root "sessions#index"
  get '/auth/:provider/callback' => "sessions#create"
  get "/signout" => "sessions#destroy"
  get "/register" => "users#register"
  post '/create_avatar' => "users#create_avatar"

end
