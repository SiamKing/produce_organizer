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
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/users/signup', locals: {message: "Please fill out all of the fields"}
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect to '/users/user' # flash message: You have successfully created an account
    end
  end

  get '/users/login' do
    if session[:id]
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
      redirect '/' # message: looks like your info didn't match up. please try again
    end
  end

  get '/users/user' do
    if session[:user_id]
      @user = current_user
      erb :'/users/user'
    else
      redirect '/users/login' #message :please login
    end
  end

  get '/users/logout' do
    if current_user
      session.clear
      redirect '/users/login' # message : logout succesful see you soon
    else
      redirect '/'
    end
  end

end
