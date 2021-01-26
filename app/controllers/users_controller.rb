class UsersController < ApplicationController

    get '/users/:id' do
        @user = User.find(params[:id])
        if logged_in? && current_user == @user
            erb :'/users/show'
        else
            erb :'/login'
        end
    end

end
