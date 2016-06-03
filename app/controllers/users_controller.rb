class UsersController < ApplicationController

  get '/users/signup' do
    if current_user
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
      redirect to '/users/user'
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
    binding.pry
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect'/users/user'
    else
      redirect '/users/login'
    end
  end

  get '/users/user' do
    if current_user
      @user = current_user
      erb :'/users/user'
    else
      redirect '/users/login'
    end
  end

  get '/users/logout' do
    if current_user
      session.clear
      redirect '/users/login'
    else
      redirect '/'
    end
  end

end
