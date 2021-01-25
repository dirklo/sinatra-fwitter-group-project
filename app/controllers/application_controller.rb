require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    erb :index
  end

  get '/login' do
    if session[:user_id]
      redirect '/tweets'
    end

    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/signup' do
    if session[:user_id]
      redirect '/tweets/index'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      user = User.create(username: params[:username], email: params[:email], password: params[:password]) 
      session[:user_id] = user.id
      redirect '/tweets' 
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end



end
