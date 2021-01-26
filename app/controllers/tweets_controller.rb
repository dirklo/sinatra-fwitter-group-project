class TweetsController < ApplicationController

    get '/tweets' do
        if !logged_in?
            redirect '/login' 
        else
            @tweets = Tweet.all
            @user = User.find(session[:user_id])
            erb :'tweets/index'
        end
    end

    get '/tweets/new' do
        if !logged_in?
            redirect '/login'
        else
            @user = User.find(session[:user_id])
            erb :'tweets/new'
        end
    end

    get '/tweets/:id' do
        if !logged_in?
            redirect '/login'
        else
            @tweet = Tweet.find(params[:id])
            @user = User.find(session[:user_id])
            erb :'tweets/show'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in? && Tweet.find(params[:id]).user.id == current_user.id 
            @user = User.find(session[:user_id])
            @tweet = Tweet.find(params[:id])
            erb :'tweets/edit'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        # binding.pry
        if !logged_in?
            redirect '/login'
        elsif params[:content].empty? 
            redirect '/tweets/new'
        else
            user = User.find(session[:user_id])
            user.tweets.create(content: params[:content])
            redirect '/tweets'
        end
    end

    patch '/tweets/:id' do
        if !logged_in?
            redirect '/login'
        elsif params[:content].empty?
            redirect "/tweets/#{params[:id]}/edit" 
        else
            @user = User.find(session[:user_id])
            tweet = Tweet.find(params[:id])
            tweet.content = params[:content]
            tweet.save
            redirect '/tweets'
        end
    end

    delete '/tweets/:id' do
        if logged_in? && Tweet.find(params[:id]).user.id == current_user.id 
            tweet = Tweet.find(params[:id])
            tweet.destroy
        else
            redirect '/tweets'
        end
    end

    
end
