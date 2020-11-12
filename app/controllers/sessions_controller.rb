class SessionsController < ApplicationController

  get '/login' do
    erb :'sessions/login'
  end

  post '/login' do
    user = User.find_by_username(params[:username])
    if user
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/super_secret"
        #They should be able to see the message
      else
        "Hey we found a user with that username, but that password wasn't right!"
      end
    else
      "Hey that user doesn't exist! We can't a find a user by that username"
    end
  end

  get '/super_secret' do
    if session[:user_id]
      "You're logged in! The secret is french fries!!!!"
    else
      "Hey if you want to know the secret you have to be logged in."
    end
  end

  get '/logout' do
    session.clear
    redirect "/super_secret"
  end

end
