class TweetsController < ApplicationController

    get '/tweets' do
        if !session[:user_id] 
            redirect '/login' 
        else
            @tweets = Tweet.all
            @user = User.find(session[:user_id])
            erb :'tweets/index'
        end
    end
end
