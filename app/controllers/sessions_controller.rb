class SessionsController < ApplicationController
  def index
    # redirect_to "/chatrooms" if signed_in?
  end
  
  #Logging in via Twitter Oauth
  def create
  	auth = request.env["omniauth.auth"]
    session[:oauth_token] = auth.credentials.token
    session[:oauth_token_secret] = auth.credentials.secret
    session[:username] = auth.extra.access_token.params[:screen_name]

    if User.exists?(username: session[:username]) == false
    	User.create(username: session[:username], token: session[:oauth_token])
      redirect_to register_path, :notice => "Welcome to Chat.ly!"
    else
      redirect_to chatrooms_path, :notice => "Welcome back #{session[:username]}!"
    end
  end

  def destroy
    session[:username] = nil
    session[:oauth_token] = nil
    redirect_to root_path
  end

  def how_to

  end

end
