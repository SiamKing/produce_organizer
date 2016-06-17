require 'rack-flash'

class UsersController < ApplicationController

  use Rack::Flash

  get '/users/signup' do
    if session[:user_id]
      redirect '/users/user'
    else
      erb :'/users/signup'
    end
  end

  post '/users/signup' do
    if signup_blank? #helper
      flash[:notice] = "Please fill out all of the fields"
      redirect '/users/signup'
    elsif username_taken? # helper
      flash[:notice] = "Username taken. Please choose another name."
      redirect '/users/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      flash[:notice] = "Congratulations! You have successfully created an account!"
      redirect to '/users/user'
    end
  end

  get '/users/login' do
    if session[:user_id]
      redirect '/users/user'
    else
      erb :'/users/login'
    end
  end

  post '/users/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect'/users/user'
    else
      flash[:notice] = "Looks like your info didn't match up. If you don't have an account, please signup. Otherwise, try loggin in again."
      redirect '/'
    end
  end

  get '/users/user' do
    if session[:user_id]
      @user = current_user
      @user_produce = @user.produce
      erb :'/users/user'
    else
      flash[:notice] = "Please login"
      redirect '/users/login'
    end
  end

  get '/users/logout' do
    if current_user
      session.destroy
      flash[:notice] = "Log out successful. Hope to see you back soon!"
      redirect '/users/login'
    else
      redirect '/'
    end
  end

  helpers do

    def signup_blank?
      User.blank?(params)
      # params[:username] == "" || params[:email] == "" || params[:password] == "" || params[:number]
    end

    def username_taken?
      User.find_by(username: params[:username])
    end

  end

end
